# import os
# import json
# import pandas as pd

# from app.ml.cluster_rebalancer import haversine

# def assign_and_rebalance_pdv(new_pdv, wilaya_boundaries, threshold):
#     # Check if the CSV file exists
#     if not os.path.exists("cleaned_pdv_data.csv"):
#         return {"status": "error", "message": "cleaned_pdv_data.csv file not found"}

#     # Proceed to read the CSV file
#     df_cleaned = pd.read_csv("cleaned_pdv_data.csv")

#     with open("rebalanced_clusters.json", "r", encoding="utf-8") as f:
#         rebalanced_clusters = json.load(f)

#     with open("best_workload_parameters.json", "r", encoding="utf-8") as f:
#         best_params = json.load(f)

#     alpha = best_params['best_alpha']
#     beta = best_params['best_beta']

#     centroids = {
#         int(cid.split('_')[1]): (
#             cluster_data["centroid"]["latitude"],
#             cluster_data["centroid"]["longitude"]
#         )
#         for cid, cluster_data in rebalanced_clusters.items()
#     }

#     def is_within_wilaya(pdv, wilaya_boundaries):
#         lat_min, lat_max, lon_min, lon_max = wilaya_boundaries
#         return lat_min <= pdv["latitude"] <= lat_max and lon_min <= pdv["longitude"] <= lon_max

#     def update_cluster_stats(cluster_key, cluster_data):
#         pdvs = cluster_data[cluster_key]["pdvs"]
#         centroid = cluster_data[cluster_key]["centroid"]
#         total_distance = sum(
#             haversine(pdv['latitude'], pdv['longitude'], centroid["latitude"], centroid["longitude"])
#             for pdv in pdvs
#         )
#         avg_distance = total_distance / len(pdvs) if pdvs else 0
#         cluster_data[cluster_key]["avg_distance_km"] = avg_distance
#         cluster_data[cluster_key]["num_of_pdvs"] = len(pdvs)

#     def assign_pdv_to_cluster(new_pdv, centroids, clusters, alpha, beta, threshold):
#         def initial_nearest_cluster(pdv, centroids):
#             min_dist = float('inf')
#             best_cid = None
#             for cid, centroid in centroids.items():
#                 dist = haversine(pdv["latitude"], pdv["longitude"], centroid[0], centroid[1])
#                 if dist < min_dist:
#                     min_dist = dist
#                     best_cid = cid
#             return best_cid

#         def calculate_single_workload(cluster, alpha, beta):
#             return alpha * cluster["avg_distance_km"] + beta * cluster["num_of_pdvs"]

#         def rebalance_cluster(overloaded_cid):
#             cluster_key = f"cluster_{overloaded_cid}"
#             centroid = centroids[overloaded_cid]
#             cluster_pdvs = clusters[cluster_key]["pdvs"]

#             while True:
#                 farthest_pdv = max(
#                     cluster_pdvs,
#                     key=lambda pdv: haversine(pdv["latitude"], pdv["longitude"], centroid[0], centroid[1])
#                 )
#                 distances = sorted(
#                     [(cid, haversine(farthest_pdv["latitude"], farthest_pdv["longitude"], centroids[cid][0], centroids[cid][1]))
#                      for cid in centroids if cid != overloaded_cid],
#                     key=lambda x: x[1]
#                 )

#                 moved = False
#                 for target_cid, _ in distances:
#                     target_key = f"cluster_{target_cid}"
#                     cluster_pdvs.remove(farthest_pdv)
#                     clusters[target_key]["pdvs"].append(farthest_pdv)
#                     farthest_pdv["cluster"] = target_cid

#                     update_cluster_stats(cluster_key, clusters)
#                     update_cluster_stats(target_key, clusters)

#                     new_workload = calculate_single_workload(clusters[cluster_key], alpha, beta)

#                     if new_workload <= threshold:
#                         moved = True
#                         break
#                     else:
#                         clusters[target_key]["pdvs"].remove(farthest_pdv)
#                         cluster_pdvs.append(farthest_pdv)
#                         farthest_pdv["cluster"] = overloaded_cid
#                         update_cluster_stats(cluster_key, clusters)
#                         update_cluster_stats(target_key, clusters)

#                 if not moved or new_workload <= threshold:
#                     break

#         best_cluster = initial_nearest_cluster(new_pdv, centroids)
#         new_pdv["cluster"] = best_cluster
#         clusters[f"cluster_{best_cluster}"]["pdvs"].append(new_pdv)
#         update_cluster_stats(f"cluster_{best_cluster}", clusters)

#         workloads = {
#             cid: calculate_single_workload(cluster, alpha, beta)
#             for cid, cluster in clusters.items()
#         }
#         max_workload = max(workloads.values())
#         min_workload = min(workloads.values())
#         threshold_new = max_workload - min_workload

#         if threshold_new > threshold:
#             rebalance_cluster(best_cluster)

#         return new_pdv, clusters

#     if is_within_wilaya(new_pdv, wilaya_boundaries):
#         updated_pdv, updated_clusters = assign_pdv_to_cluster(new_pdv, centroids, rebalanced_clusters, alpha, beta, threshold)

#         cluster_id = updated_pdv["cluster"]
#         cluster_key = f"cluster_{cluster_id}"
#         if cluster_key not in updated_clusters:
#             updated_clusters[cluster_key] = {"centroid": centroids[cluster_id], "pdvs": []}
#         updated_clusters[cluster_key]["pdvs"].append(updated_pdv)
#         update_cluster_stats(cluster_key, updated_clusters)

#         with open("rebalanced_add_clusters.json", "w", encoding="utf-8") as f:
#             json.dump(updated_clusters, f, ensure_ascii=False, indent=4)

#         return {"status": "success", "assigned_cluster": cluster_id}
#     else:
#         return {"status": "out_of_bounds", "message": "PDV is outside the managed wilaya."}






import json
import pandas as pd
from math import radians, sin, cos, sqrt, atan2
import numpy as np
import copy
import sys

threshold = 8

# ------------------ [LOAD PREVIOUS DATA] ------------------
try:
    df_cleaned = pd.read_csv("Wilaya_CSVs/cleaned_pdv_data.csv")

    with open("Wilaya_CSVs/rebalanced_clusters.json", "r", encoding="utf-8") as f:
        rebalanced_clusters = json.load(f)

    with open("Wilaya_CSVs/best_workload_parameters.json", "r", encoding="utf-8") as f:
        best_params = json.load(f)

    alpha = best_params['best_alpha']
    beta = best_params['best_beta']
except Exception as e:
    print(f"Error loading data: {str(e)}")
    sys.exit(1)

# Check if rebalanced_clusters is empty or doesn't have centroids
if not rebalanced_clusters:
    print("Error: rebalanced_clusters is empty. Cannot proceed.")
    sys.exit(1)

centroids = {
    int(cid.split('_')[1]): (
        cluster_data["centroid"]["latitude"],
        cluster_data["centroid"]["longitude"]
    )
    for cid, cluster_data in rebalanced_clusters.items()
    if "centroid" in cluster_data and "latitude" in cluster_data["centroid"] and "longitude" in cluster_data["centroid"]
}

# Make sure centroids dictionary is not empty
if not centroids:
    print("Error: No valid centroids found in rebalanced_clusters. Check your data structure.")
    for cid, cluster_data in rebalanced_clusters.items():
        print(f"Cluster {cid} data: {cluster_data}")
    sys.exit(1)

# ------------------ [DEFINE NEW PDV DATA] ------------------
new_pdv = {
    "latitude": 36.7528,
    "longitude": 3.0588,
    "cluster": None,
}

# ------------------ [DEFINE WILAYA BOUNDARIES] ------------------
wilaya_boundaries = (36.0, 37.0, 2.5, 4.0)

# ------------------ [HELPER FUNCTIONS] ------------------

def haversine(lat1, lon1, lat2, lon2):
    R = 6371
    lat1, lon1, lat2, lon2 = map(radians, [lat1, lon1, lat2, lon2])
    dlat = lat2 - lat1
    dlon = lon2 - lon1
    a = sin(dlat / 2)**2 + cos(lat1) * cos(lat2) * sin(dlon / 2)**2
    c = 2 * atan2(sqrt(a), sqrt(1 - a))
    return R * c

def euclidean_distance(pdv, centroid):
    return sqrt((pdv["latitude"] - centroid[0])**2 + (pdv["longitude"] - centroid[1])**2)

def compute_workloads(clusters, alpha=alpha, beta=beta):
    workloads = []
    if not clusters:
        print("Warning: Empty clusters dictionary in compute_workloads")
        return [0]  # Return a non-empty list with a default value
        
    for cluster in clusters.values():
        if isinstance(cluster, dict):
            workload = alpha * cluster.get("avg_distance_km", 0) + beta * cluster.get("num_of_pdvs", 0)
        else:
            # Handle cluster list (maybe it's a list of dicts)
            workload = 0
            for sub_cluster in cluster:
                workload += alpha * sub_cluster.get("avg_distance_km", 0) + beta * sub_cluster.get("num_of_pdvs", 0)

        workloads.append(workload)
    
    if not workloads:  # Safety check
        return [0]
    return workloads

def is_within_wilaya(pdv, wilaya_boundaries):
    lat_min, lat_max, lon_min, lon_max = wilaya_boundaries
    return lat_min <= pdv["latitude"] <= lat_max and lon_min <= pdv["longitude"] <= lon_max

def update_cluster_stats(cluster_key, cluster_data):
    pdvs = cluster_data[cluster_key]["pdvs"]
    centroid = cluster_data[cluster_key]["centroid"]
    total_distance = sum(
        haversine(pdv['latitude'], pdv['longitude'], centroid["latitude"], centroid["longitude"])
        for pdv in pdvs
    )
    avg_distance = total_distance / len(pdvs) if pdvs else 0
    cluster_data[cluster_key]["avg_distance_km"] = avg_distance
    cluster_data[cluster_key]["num_of_pdvs"] = len(pdvs)

def update_centroids(clusters):
    new_centroids = {}
    for cid_str, cluster in clusters.items():
        cid = int(cid_str.split("_")[1])
        pdvs = cluster["pdvs"]
        if pdvs:
            avg_lat = sum(p["latitude"] for p in pdvs) / len(pdvs)
            avg_lon = sum(p["longitude"] for p in pdvs) / len(pdvs)
        else:
            avg_lat = cluster["centroid"]["latitude"]
            avg_lon = cluster["centroid"]["longitude"]
        cluster["centroid"]["latitude"] = avg_lat
        cluster["centroid"]["longitude"] = avg_lon
        new_centroids[cid] = (avg_lat, avg_lon)
    return new_centroids

# ------------------ [REBALANCING FUNCTION] ------------------

def rebalance_cluster(clusters, cluster_workloads, cluster_centroids, threshold):
    initial_clusters = copy.deepcopy(clusters)
    improved = False

    while True:
        workloads = compute_workloads(clusters)
        variance = np.var(workloads)
        max_wl = max(workloads)
        min_wl = min(workloads)

        if (max_wl - min_wl) <= threshold:
            break

        overloaded_index = workloads.index(max_wl)
        overloaded_key = f"cluster_{overloaded_index}"
        overloaded_centroid = cluster_centroids[overloaded_index]
        pdvs = clusters[overloaded_key]["pdvs"]

        if not pdvs:
            break

        farthest_pdv = max(
            pdvs,
            key=lambda pdv: euclidean_distance(pdv, overloaded_centroid)
        )
        dist_to_current = euclidean_distance(farthest_pdv, overloaded_centroid)

        possible_moves = [
            (i, euclidean_distance(farthest_pdv, centroid))
            for i, centroid in cluster_centroids.items()
            if i != overloaded_index and euclidean_distance(farthest_pdv, centroid) < dist_to_current
        ]

        if not possible_moves:
            break

        nearest_cluster_idx = min(possible_moves, key=lambda x: x[1])[0]
        target_key = f"cluster_{nearest_cluster_idx}"

        clusters[overloaded_key]["pdvs"].remove(farthest_pdv)
        clusters[target_key]["pdvs"].append(farthest_pdv)

        update_cluster_stats(overloaded_key, clusters)
        update_cluster_stats(target_key, clusters)
        cluster_centroids = update_centroids(clusters)

        new_workloads = compute_workloads(clusters)
        new_variance = np.var(new_workloads)

        if new_variance < variance:
            improved = True
        else:
            clusters[target_key]["pdvs"].remove(farthest_pdv)
            clusters[overloaded_key]["pdvs"].append(farthest_pdv)
            update_cluster_stats(overloaded_key, clusters)
            update_cluster_stats(target_key, clusters)
            cluster_centroids = update_centroids(clusters)
            break

    if not improved:
        print(" >> No improvement after full rebalance cycle. Reverting to original clusters.")
        clusters.clear()
        clusters.update(initial_clusters)

# ------------------ [ASSIGN NEW PDV TO CLUSTER] ------------------

def assign_pdv_to_cluster(new_pdv, centroids, clusters, alpha, beta, threshold):
    def initial_nearest_cluster(pdv, centroids):
        if not centroids:
            print("Error: No centroids available to assign PDV to.")
            return None
        
        return min(
            centroids.items(),
            key=lambda item: haversine(pdv["latitude"], pdv["longitude"], item[1][0], item[1][1])
        )[0]

    pre_workloads = compute_workloads(clusters)
    print("\n >> Workload stats BEFORE adding new PDV:")
    print(f" - Variance: {np.var(pre_workloads):.4f}")
    print(f" - Max - Min: {max(pre_workloads) - min(pre_workloads):.4f}")

    best_cluster = initial_nearest_cluster(new_pdv, centroids)
    if best_cluster is None:
        print("Cannot assign PDV - no valid clusters found.")
        return new_pdv
        
    new_pdv["cluster"] = best_cluster
    cluster_key = f"cluster_{best_cluster}"
    clusters[cluster_key]["pdvs"].append(new_pdv)
    update_cluster_stats(cluster_key, clusters)

    post_assign_workloads = compute_workloads(clusters)
    print("\n >> After assigning PDV (before rebalancing):")
    print(f" - Variance: {np.var(post_assign_workloads):.4f}")
    print(f" - Max - Min: {max(post_assign_workloads) - min(post_assign_workloads):.4f}")

    if max(post_assign_workloads) - min(post_assign_workloads) > threshold:
        print("!!  Imbalance detected. Rebalancing required...")
        updated_centroids = update_centroids(clusters)
        rebalance_cluster(clusters, post_assign_workloads, updated_centroids, threshold)

        post_rebalance_workloads = compute_workloads(clusters)
        print("\n >> After rebalancing:")
        print(f" - Variance: {np.var(post_rebalance_workloads):.4f}")
        print(f" - Max - Min: {max(post_rebalance_workloads) - min(post_rebalance_workloads):.4f}")
    else:
        print(" Workload within threshold. No rebalancing needed.")

    return new_pdv

# Function to export for the API
def assign_and_rebalance_pdv(new_pdv_data):
    """
    This function is called from the API to add a new PDV and rebalance clusters if needed.
    
    Args:
        new_pdv_data (dict): Dictionary containing latitude and longitude of new PDV
        
    Returns:
        dict: Updated PDV data with cluster assignment
    """
    # Create a copy to avoid modifying the input
    pdv_copy = {
        "latitude": new_pdv_data["latitude"],
        "longitude": new_pdv_data["longitude"],
        "cluster": None
    }
    
    if is_within_wilaya(pdv_copy, wilaya_boundaries):
        try:
            updated_pdv = assign_pdv_to_cluster(pdv_copy, centroids, rebalanced_clusters, alpha, beta, threshold)
            
            # Save updated clusters to file
            with open("Wilaya_CSVs/rebalanced_clusters.json", "w", encoding="utf-8") as f:
                json.dump(rebalanced_clusters, f, ensure_ascii=False, indent=4)
                
            return updated_pdv
        except Exception as e:
            print(f"Error during PDV assignment: {str(e)}")
            return {"error": str(e)}
    else:
        return {"error": "PDV is outside of the managed wilaya boundaries"}

# ------------------ [MAIN LOGIC] ------------------

if __name__ == "__main__":
    if not centroids:
        print("Error: Cannot proceed with empty centroids dictionary.")
        sys.exit(1)
        
    if is_within_wilaya(new_pdv, wilaya_boundaries):
        print(" PDV is within the wilaya range.")
        try:
            updated_pdv = assign_pdv_to_cluster(new_pdv, centroids, rebalanced_clusters, alpha, beta, threshold)
            if updated_pdv["cluster"] is not None:
                cluster_id = updated_pdv["cluster"]
                print(f" New PDV assigned to cluster_{cluster_id}")
            else:
                print(" Failed to assign PDV to any cluster.")
        except Exception as e:
            print(f"Error during PDV assignment: {str(e)}")
            sys.exit(1)
    else:
        print(" PDV is outside of the managed wilaya. Skipping.")

    # ------------------ [DISPLAY FINAL STATS] ------------------

    print("\n Final Cluster Stats")
    print("Cluster    Num of PDVs     Avg Distance (km)     Workload (%)")
    print("--------------------------------------------------")

    workload_values = {
        cid: alpha * cluster["avg_distance_km"] + beta * cluster["num_of_pdvs"]
        for cid, cluster in rebalanced_clusters.items()
    }
    sum_workload = sum(workload_values.values())

    for cid, cluster in rebalanced_clusters.items():
        num_pdvs = cluster["num_of_pdvs"]
        avg_distance = cluster["avg_distance_km"]
        workload = workload_values[cid]
        workload_percentage = (workload / sum_workload) * 100
        print(f"{cid:<10} {num_pdvs:<15} {avg_distance:<18.2f} {workload_percentage:<15.2f}")

    print("--------------------------------------------------")
    print(f" Total workload percentage: 100.00%")

    # ------------------ [SAVE RESULT] ------------------

    with open("Wilaya_CSVs/rebalanced_clusters.json", "w", encoding="utf-8") as f:
        json.dump(rebalanced_clusters, f, ensure_ascii=False, indent=4)

    print("\n New PDV added and clusters saved with rebalancing (if needed).")