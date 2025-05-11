# backend_fast_API/main.py
from fastapi import FastAPI, Depends, HTTPException, status
from sqlalchemy.orm import Session
from sqlalchemy.exc import IntegrityError
from .database import SessionLocal, engine
from . import models
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, EmailStr, validator
import hashlib
import logging

# Set up logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Create tables
models.Base.metadata.create_all(bind=engine)

app = FastAPI()

# Configure CORS with more specific settings
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://10.80.4.216"],  # Your Flutter app's IP
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Pydantic model for user registration with validation
class UserCreate(BaseModel):
    fullname: str
    email: EmailStr
    phone: str
    manager: str
    password: str
    
    @validator('password')
    def password_must_be_strong(cls, v):
        if len(v) < 6:
            raise ValueError('Password must be at least 6 characters')
        return v

# Pydantic model for user login
class UserLogin(BaseModel):
    email: EmailStr
    password: str

class UserResponse(BaseModel):
    id_users: int
    fullname: str
    email: str
    phone: str
    manager: str
    
    class Config:
        from_attributes = True  # Updated from orm_mode

# Helper function to hash passwords
def hash_password(password: str) -> str:
    # In production, use a more secure method like bcrypt
    return hashlib.sha256(password.encode()).hexdigest()

# Dependency to get DB session
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

# Root endpoint
@app.get("/")
def read_root():
    return {"message": "FastAPI with PostgreSQL working!"}

# User registration endpoint
@app.post("/api/signup", status_code=status.HTTP_201_CREATED)
def signup(user: UserCreate, db: Session = Depends(get_db)):
    try:
        logger.info(f"Signup attempt for email: {user.email}")
        
        # Check if user already exists
        existing_user = db.query(models.User).filter(models.User.email == user.email).first()
        if existing_user:
            logger.warning(f"Signup failed: Email already registered: {user.email}")
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST, 
                detail="Email already registered"
            )
        
        # Create new user with hashed password
        hashed_password = hash_password(user.password)
        db_user = models.User(
            fullname=user.fullname,
            email=user.email,
            phone=user.phone,
            manager=user.manager,
            password=hashed_password
        )
        
        db.add(db_user)
        db.commit()
        db.refresh(db_user)
        
        logger.info(f"User registered successfully: {user.email}")
        
        # Return user without password
        return {
            "message": "User registered successfully", 
            "user": {
                "id_users": db_user.id_users,
                "fullname": db_user.fullname,
                "email": db_user.email,
                "phone": db_user.phone,
                "manager": db_user.manager
            }
        }
        
    except IntegrityError as e:
        db.rollback()
        logger.error(f"Database integrity error during signup: {str(e)}")
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST, 
            detail="Email already registered"
        )
    except Exception as e:
        db.rollback()
        logger.error(f"Unexpected error during signup: {str(e)}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, 
            detail=f"Registration failed: {str(e)}"
        )

# Login endpoint
@app.post("/api/login")
def login(user_data: UserLogin, db: Session = Depends(get_db)):
    try:
        logger.info(f"Login attempt for email: {user_data.email}")
        
        # Find user by email
        user = db.query(models.User).filter(models.User.email == user_data.email).first()
        
        if not user or hash_password(user_data.password) != user.password:
            logger.warning(f"Login failed: Invalid credentials for {user_data.email}")
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,  
                detail="Invalid email or password"
            )
        logger.info(f"Login successful: {user_data.email}")
        
        # Return user info (without password)
        return {
            "message": "Login successful",
            "user": {
                "id_users": user.id_users,
                "fullname": user.fullname,
                "email": user.email,
                "phone": user.phone,
                "manager": user.manager
            }
        }
        
    except HTTPException:
        # Re-raise HTTP exceptions without logging them as errors
        raise
    except Exception as e:
        logger.error(f"Unexpected error during login: {str(e)}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, 
            detail=f"Login failed: {str(e)}"
        )

# Get user profile endpoint
@app.get("/api/users/{user_id}", response_model=UserResponse)
def get_user(user_id: int, db: Session = Depends(get_db)):
    user = db.query(models.User).filter(models.User.id_users == user_id).first()
    if not user:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND, 
            detail="User not found"
        )
    return user




#.\venv\Scripts\activate
#uvicorn backend_fast_API.main:app --reload
