from typing import Optional
from pydantic_settings import BaseSettings, SettingsConfigDict
from pydantic import Field


class SimSettings(BaseSettings):

    # Application

    """
    Root directory of all application specific local storage items/artifacts. This
    is where client configs, simulator input files, simulation artifact files will
    be located by default.
    """
    APP_CFG_DIR: str = Field(default="/opt/isr-debris-simulator")
    CFG_ROOT: str = Field(default="/opt/isr-debris-simulator")

    # Storage

    """
    Root directory of orbital object, and radar data files. Simulator will ingest TLE, Radar,
    ISR data files contained withtin the folder structure in SDM_DATA. Further documentation
    is located under `docs/local-storage.md`.
    """
    DATA_ROOT: str = Field(default="/opt/isr-debris-simulator/SDM_DATA")
    
    # SpaceTrack

    model_config = SettingsConfigDict(env_file=".env", extra="ignore")

def get_global_configs() -> SimSettings:
    """Application Environment Variables"""
    return SimSettings()

