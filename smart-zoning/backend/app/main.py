from fastapi import FastAPI
import uvicorn
from app.routes import pdv_routes
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI(
    title="PDV Clustering API",
    description="API for clustering PDV (points of sale) data",
    version="1.0.0"
)

# Add CORS middleware to allow requests from your Flutter app
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # In production, replace with your actual frontend domain
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)





# Include routes
app.include_router(pdv_routes.router, prefix="/pdv", tags=["PDV Clustering"])

@app.get("/", tags=["Root"])
async def read_root():
    return {
        "message": "Welcome to PDV Clustering API",
        "docs": "/docs",
        "upload_endpoint": "/pdv/upload-csv/"
    }

if __name__ == "__main__":
    uvicorn.run("main:app", host="0.0.0.0", port=8000, reload=True)