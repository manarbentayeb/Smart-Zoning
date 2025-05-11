from sqlalchemy import Column, Integer, String
from .database import Base

class User(Base):
    __tablename__ = 'users'
    
    id_users = Column(Integer, primary_key=True, index=True)
    fullname = Column(String)
    email = Column(String, unique=True)
    phone = Column(String)
    manager = Column(String)
    password = Column(String)  