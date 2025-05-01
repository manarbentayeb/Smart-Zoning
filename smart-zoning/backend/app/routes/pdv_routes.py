from fastapi import APIRouter, UploadFile, File, HTTPException, Form
import shutil
import os
from app.services.clustering_service import run_clustering_pipeline
from typing import Optional

router = APIRouter()

UPLOAD_DIR = "uploaded_files"
os.makedirs(UPLOAD_DIR, exist_ok=True)

@router.post("/upload-csv/")
async def upload_csv(
    file: UploadFile = File(...),
    n_clusters: Optional[int] = Form(5)
):
    """
    Upload a CSV file and process it with the clustering algorithm.
    
    Args:
        file: CSV file to upload
        n_clusters: Number of clusters to create (default: 5)
        
    Returns:
        Processing results
    """
    # Validate file
    if not file.filename.endswith('.csv'):
        raise HTTPException(status_code=400, detail="Only CSV files are accepted.")

    # Create a unique filename to avoid overwriting
    filename = f"{os.path.splitext(file.filename)[0]}_{os.urandom(4).hex()}.csv"
    file_path = os.path.join(UPLOAD_DIR, filename)
    
    # Save the file
    try:
        with open(file_path, "wb") as buffer:
            shutil.copyfileobj(file.file, buffer)
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error saving file: {str(e)}")

    # Run clustering pipeline
    result = run_clustering_pipeline(file_path, n_clusters=n_clusters)
    
    if not result.get("success", False):
        raise HTTPException(
            status_code=500, 
            detail=f"Processing failed: {result.get('error', 'Unknown error')}"
        )

    return {
        "message": "File uploaded and processed successfully",
        "file_name": filename,
        "result": result
    }

@router.get("/status/")
async def get_status():
    """
    Check if the API is running.
    """
    return {
        "status": "online",
        "message": "PDV Clustering API is running"
    }