import pandas as pd
import os

def preprocess_data(file_path: str):
    """
    Preprocess the uploaded CSV file.
    
    Args:
        file_path: Path to the uploaded CSV file
        
    Returns:
        Preprocessed DataFrame
    """
    if not os.path.exists(file_path):
        raise FileNotFoundError(f"File not found: {file_path}")
    
    # Load data
    df = pd.read_csv(file_path)
    
    # Data cleaning
    df.dropna(inplace=True)
    
    # Round coordinates for consistency
    if 'Latitude' in df.columns and 'Longitude' in df.columns:
        df['Latitude'] = df['Latitude'].round(6)
        df['Longitude'] = df['Longitude'].round(6)
    
    print(f"Preprocessing complete: {df.shape[0]} rows after cleaning")
    return df