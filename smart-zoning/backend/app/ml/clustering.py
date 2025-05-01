import pandas as pd
import numpy as np
from sklearn.cluster import KMeans
import os

def run_clustering(df, n_clusters=5):
    """
    Run KMeans clustering on the preprocessed data.
    
    Args:
        df: Preprocessed DataFrame with Latitude and Longitude columns
        n_clusters: Number of clusters to create
        
    Returns:
        Dictionary with clustering results
    """
    # Check if the dataframe has the required columns
    if 'Latitude' not in df.columns or 'Longitude' not in df.columns:
        raise ValueError("DataFrame must contain 'Latitude' and 'Longitude' columns")
    
    # Extract coordinates
    coords = df[['Latitude', 'Longitude']].to_numpy()
    coords_rad = np.radians(coords)
    
    # Run KMeans
    kmeans = KMeans(n_clusters=n_clusters, init='k-means++', n_init=10, random_state=42)
    kmeans.fit(coords_rad)
    
    # Add cluster labels to original data
    df_clustered = df.copy()
    df_clustered['Cluster'] = kmeans.labels_
    
    # Calculate cluster statistics
    cluster_stats = df_clustered.groupby('Cluster').agg({
        'Latitude': ['count', 'mean'],
        'Longitude': ['mean']
    })
    cluster_stats.columns = ['PDV_Count', 'Avg_Latitude', 'Avg_Longitude']
    
    # Convert centroids to degrees
    centroids_deg = np.degrees(kmeans.cluster_centers_)
    
    # Create output folder if it doesn't exist
    output_folder = os.path.join(os.getcwd(), "Wilaya_CSVs")
    os.makedirs(output_folder, exist_ok=True)
    
    # Save results
    output_file = os.path.join(output_folder, "clustering_results.csv")
    df_clustered.to_csv(output_file, index=False)
    
    # Return results
    return {
        "num_points": len(df),
        "num_clusters": n_clusters,
        "clusters": [
            {
                "cluster_id": i,
                "num_points": int(cluster_stats.iloc[i]['PDV_Count']),
                "centroid": {
                    "latitude": float(centroids_deg[i][0]),
                    "longitude": float(centroids_deg[i][1])
                }
            }
            for i in range(n_clusters)
        ],
        "output_file": output_file
    }