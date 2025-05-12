# import json
# import statistics
# import os
# import logging

# from ..ml.add_pdv import assign_and_rebalance_pdv
# from app.ml.cluster_rebalancer import haversine

# def calculate_workload_variance(clusters, alpha, beta):
#     workloads = [
#         alpha * c["avg_distance_km"] + beta * c["num_of_pdvs"]
#         for c in clusters.values()
#     ]
#     total = sum(workloads)
#     if total == 0:
#         return 0.0
#     percentages = [(w / total) * 100 for w in workloads]
#     return statistics.variance(percentages)



# def update_cluster_stats(cluster_key, cluster_data):
#     pdvs = cluster_data[cluster_key]["pdvs"]
#     if not pdvs:
#         cluster_data[cluster_key]["avg_distance_km"] = 0
#         cluster_data[cluster_key]["num_of_pdvs"] = 0
#         return
#     centroid = cluster_data[cluster_key]["centroid"]
#     total_distance = sum(
#         haversine(pdv['latitude'], pdv['longitude'], centroid["latitude"], centroid["longitude"])
#         for pdv in pdvs
#     )
#     avg_distance = total_distance / len(pdvs)
#     cluster_data[cluster_key]["avg_distance_km"] = avg_distance
#     cluster_data[cluster_key]["num_of_pdvs"] = len(pdvs)



















# def delete_pdv_and_rebalance(pdv_to_delete: dict):
#     file_path = "rebalanced_add_clusters.json"
#     if not os.path.exists(file_path):
#         logging.error(f"File '{file_path}' not found, cannot proceed with deletion and rebalancing.")
#         return {"success": False, "message": f"File '{file_path}' not found."}
    
#     try:
#         with open(file_path, "r", encoding="utf-8") as f:
#             rebalanced_clusters = json.load(f)
#     except Exception as e:
#         logging.error(f"Error reading file '{file_path}': {e}")
#         return {"success": False, "message": f"Error reading file '{file_path}': {e}"}

#     file_path_best_params = "best_workload_parameters.json"
#     if not os.path.exists(file_path_best_params):
#         logging.error(f"File '{file_path_best_params}' not found.")
#         return {"success": False, "message": f"File '{file_path_best_params}' not found."}
    
#     try:
#         with open(file_path_best_params, "r", encoding="utf-8") as f:
#             best_params = json.load(f)
#     except Exception as e:
#         logging.error(f"Error reading file '{file_path_best_params}': {e}")
#         return {"success": False, "message": f"Error reading file '{file_path_best_params}': {e}"}

#     alpha = best_params['best_alpha']
#     beta = best_params['best_beta']

#     variance_before = calculate_workload_variance(rebalanced_clusters, alpha, beta)

#     deleted = False
#     deleted_cluster_key = None
#     for cluster_key, cluster in rebalanced_clusters.items():
#         pdvs = cluster["pdvs"]
#         for pdv in pdvs:
#             if (abs(pdv["latitude"] - pdv_to_delete["latitude"]) < 1e-6 and
#                 abs(pdv["longitude"] - pdv_to_delete["longitude"]) < 1e-6):
#                 pdvs.remove(pdv)
#                 update_cluster_stats(cluster_key, rebalanced_clusters)
#                 deleted = True
#                 deleted_cluster_key = cluster_key
#                 break
#         if deleted:
#             break

#     if not deleted:
#         return {"success": False, "message": "PDV not found in any cluster."}

#     # Try to rebalance
#     remaining_pdvs = rebalanced_clusters[deleted_cluster_key]["pdvs"]
#     if remaining_pdvs:
#         reference = pdv_to_delete
#         closest_pdv = min(remaining_pdvs, key=lambda p: haversine(
#             p["latitude"], p["longitude"], reference["latitude"], reference["longitude"]
#         ))

#         closest_cluster_key = None
#         closest_distance = float("inf")

#         for cid, c in rebalanced_clusters.items():
#             if cid == deleted_cluster_key or not c["pdvs"]:
#                 continue
#             cluster_center_lat = sum(p["latitude"] for p in c["pdvs"]) / len(c["pdvs"])
#             cluster_center_lon = sum(p["longitude"] for p in c["pdvs"]) / len(c["pdvs"])
#             dist = haversine(closest_pdv["latitude"], closest_pdv["longitude"], cluster_center_lat, cluster_center_lon)
#             if dist < closest_distance:
#                 closest_distance = dist
#                 closest_cluster_key = cid

#         if closest_cluster_key:
#             rebalanced_clusters[deleted_cluster_key]["pdvs"].remove(closest_pdv)
#             rebalanced_clusters[closest_cluster_key]["pdvs"].append(closest_pdv)
#             update_cluster_stats(deleted_cluster_key, rebalanced_clusters)
#             update_cluster_stats(closest_cluster_key, rebalanced_clusters)

#     variance_after = calculate_workload_variance(rebalanced_clusters, alpha, beta)

#     output_file_path = "rebalanced_delete_clusters.json"
#     try:
#         with open(output_file_path, "w", encoding="utf-8") as f:
#             json.dump(rebalanced_clusters, f, ensure_ascii=False, indent=4)
#     except Exception as e:
#         logging.error(f"Error writing to file '{output_file_path}': {e}")
#         return {"success": False, "message": f"Error writing to file '{output_file_path}': {e}"}

#     return {
#         "success": True,
#         "variance_before": variance_before,
#         "variance_after": variance_after,
#     }


import json
import statistics
from math import radians, cos, sin, asin, sqrt

# ------------------ [HAVERSINE FUNCTION] ------------------
def haversine(lat1, lon1, lat2, lon2):
    R = 6371.0
    d_lat = radians(lat2 - lat1)
    d_lon = radians(lon2 - lon1)
    a = sin(d_lat / 2)**2 + cos(radians(lat1)) * cos(radians(lat2)) * sin(d_lon / 2)**2
    c = 2 * asin(sqrt(a))
    return R * c

# ------------------ [CLUSTER STATS FUNCTIONS] ------------------
def update_cluster_stats(cluster_key, clusters):
    cluster = clusters[cluster_key]
    pdvs = cluster["pdvs"]
    if not pdvs:
        cluster["avg_distance_km"] = 0.0
        cluster["num_of_pdvs"] = 0
        return
    center_lat = sum(p["latitude"] for p in pdvs) / len(pdvs)
    center_lon = sum(p["longitude"] for p in pdvs) / len(pdvs)
    distances = [haversine(p["latitude"], p["longitude"], center_lat, center_lon) for p in pdvs]
    cluster["avg_distance_km"] = sum(distances) / len(distances)
    cluster["num_of_pdvs"] = len(pdvs)

def calculate_workload_variance(clusters, alpha, beta):
    workloads = [alpha * c["avg_distance_km"] + beta * c["num_of_pdvs"] for c in clusters.values()]
    total = sum(workloads)
    if total == 0:
        return 0.0
    percentages = [(w / total) * 100 for w in workloads]
    return statistics.variance(percentages)

def workload_diff_percent(clusters, alpha, beta):
    workloads = {cid: alpha * c["avg_distance_km"] + beta * c["num_of_pdvs"] for cid, c in clusters.items()}
    total = sum(workloads.values())
    if total == 0:
        return 0.0, 0.0, 0.0
    percentages = {cid: (w / total) * 100 for cid, w in workloads.items()}
    max_p = max(percentages.values())
    min_p = min(percentages.values())
    return max_p, min_p, max_p - min_p

# ------------------ [LOAD DATA] ------------------
path = r"C:\Users\pc cam dz\Desktop\zoning\Smart-Zoning\smart-zoning\backend\Wilaya_CSVs\rebalanced_clusters.json"
with open(path, "r", encoding="utf-8") as f:
    rebalanced_clusters = json.load(f)

with open("best_workload_parameters.json", "r", encoding="utf-8") as f:
    best_params = json.load(f)

alpha = best_params['best_alpha']
beta = best_params['best_beta']

# ------------------ [GET USER COORDINATES] ------------------
lat_input = float(input("Enter latitude of PDV to delete: "))
lon_input = float(input("Enter longitude of PDV to delete: "))

# ------------------ [FIND CLOSEST MATCHING PDV] ------------------
min_dist = float('inf')
target_pdv = None
target_cluster = None

for cluster_key, cluster in rebalanced_clusters.items():
    for pdv in cluster["pdvs"]:
        dist = haversine(lat_input, lon_input, pdv["latitude"], pdv["longitude"])
        if dist < min_dist:
            min_dist = dist
            target_pdv = pdv
            target_cluster = cluster_key

if target_pdv and min_dist < 0.05:  # Acceptable threshold (about ~50 meters)
    print(f"PDV found in cluster {target_cluster}, deleting it...")
    rebalanced_clusters[target_cluster]["pdvs"].remove(target_pdv)
    update_cluster_stats(target_cluster, rebalanced_clusters)
else:
    print("No close PDV found. Aborting.")
    exit()

# ------------------ [WORKLOAD CHECK & REBALANCE] ------------------
variance = calculate_workload_variance(rebalanced_clusters, alpha, beta)
_, _, diff = workload_diff_percent(rebalanced_clusters, alpha, beta)
print(f"Workload variance after deletion: {variance:.4f}, diff: {diff:.2f}")

if diff >= 10:
    print("Rebalancing required...")
    while diff >= 10:
        target_center_lat = sum(p["latitude"] for p in rebalanced_clusters[target_cluster]["pdvs"]) / max(len(rebalanced_clusters[target_cluster]["pdvs"]), 1)
        target_center_lon = sum(p["longitude"] for p in rebalanced_clusters[target_cluster]["pdvs"]) / max(len(rebalanced_clusters[target_cluster]["pdvs"]), 1)

        best_pdv, best_donor, best_dist = None, None, float("inf")

        for donor_key, donor_cluster in rebalanced_clusters.items():
            if donor_key == target_cluster or len(donor_cluster["pdvs"]) < 2:
                continue
            for pdv in donor_cluster["pdvs"]:
                dist = haversine(pdv["latitude"], pdv["longitude"], target_center_lat, target_center_lon)
                if dist < best_dist:
                    best_dist = dist
                    best_pdv = pdv
                    best_donor = donor_key

        if best_pdv:
            rebalanced_clusters[best_donor]["pdvs"].remove(best_pdv)
            rebalanced_clusters[target_cluster]["pdvs"].append(best_pdv)
            update_cluster_stats(best_donor, rebalanced_clusters)
            update_cluster_stats(target_cluster, rebalanced_clusters)
            print(f"Moved PDV from {best_donor} → {target_cluster}")
        else:
            print("No suitable PDV to transfer.")
            break

        _, _, diff = workload_diff_percent(rebalanced_clusters, alpha, beta)

# ------------------ [SAVE RESULT] ------------------
with open("rebalanced_delete_clusters.json", "w", encoding="utf-8") as f:
    json.dump(rebalanced_clusters, f, ensure_ascii=False, indent=4)

print("Updated clusters saved to rebalanced_delete_clusters.json")
