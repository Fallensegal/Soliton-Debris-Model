from pathlib import Path


def acquire_os_default_paths() -> dict[str, Path]:
    path_home = Path.home()
    app_config_path = path_home.joinpath("SDM")
    data_config_path = app_config_path.joinpath("SDM_DATA")
    madrigal_data_path = data_config_path.joinpath("MADRIGAL")
    spacetrack_data_path = data_config_path.joinpath("SPACETRACK")

    return {
        "HOME": path_home,
        "APP_CONFIG": app_config_path,
        "DATA_CONFIG": data_config_path,
        "SPACETRACK": spacetrack_data_path,
        "MADRIGAL": madrigal_data_path,
    }


"""
2. Acquire init parameters
3. Generate the File Structure
4. Generate the config file
5. Define init errors
6. Add Passing Test
7. Add Failing Test
"""
