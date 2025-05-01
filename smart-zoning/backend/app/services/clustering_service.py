import os
from app.ml.preprocessing import preprocess_data
from app.ml.clustering import run_clustering

def run_clustering_pipeline(file_path: str, n_clusters=5):
    """
    Run the complete clustering pipeline.
    
    Args:
        file_path: Path to the uploaded CSV file
        n_clusters: Number of clusters to create
        
    Returns:
        Dictionary with clustering results
    """
    try:
        # Check if file exists
        if not os.path.exists(file_path):
            return {
                "success": False,
                "error": f"File not found: {file_path}"
            }
        
        # Preprocess data
        df = preprocess_data(file_path)
        
        # Run clustering
        clusters = run_clustering(df, n_clusters=n_clusters)
        
        return {
            "success": True,
            "message": "Clustering completed successfully",
            "file_path": file_path,
            "results": clusters
        }
    
    except Exception as e:
        import traceback
        return {
            "success": False,
            "error": str(e),
            "traceback": traceback.format_exc()
        }