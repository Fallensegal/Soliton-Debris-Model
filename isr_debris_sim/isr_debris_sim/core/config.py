from typing import Optional, TypedDict

from pydantic import Field
from pydantic_settings import (
    BaseSettings,
    PydanticBaseSettingsSource,
    SettingsConfigDict,
    YamlConfigSettingsSource,
)


class SimSettings(BaseSettings):
    """
    Root directory of all application specific local storage items/artifacts.

    This is where client configs, simulator input files, simulation artifact files will
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

    model_config = SettingsConfigDict(yaml_file="sdm.cfg", extra="ignore")

    @classmethod
    def settings_customise_sources(
        cls,  # noqa: PLR0913
        settings_cls: type[BaseSettings],
        init_settings: PydanticBaseSettingsSource,
        env_settings: PydanticBaseSettingsSource,
        dotenv_settings: PydanticBaseSettingsSource,
        file_secret_settings: PydanticBaseSettingsSource,
    ) -> tuple[PydanticBaseSettingsSource, ...]:
        return (YamlConfigSettingsSource(settings_cls),)


def get_global_configs() -> SimSettings:
    """Application Environment Variables."""
    return SimSettings()
