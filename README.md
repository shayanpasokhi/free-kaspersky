# free-kaspersky

Free Kaspersky Scanner

> This repository contains a  **Dockerfile**  of  [kaspersky](https://www.kaspersky.com/).

## Installation

1.  Install  [Docker](https://www.docker.com/).
2.  Download  [build](https://hub.docker.com/r/shayanpasokhi/free-kaspersky)  from public  [docker hub](https://hub.docker.com/): `docker pull shayanpasokhi/free-kaspersky`

## Usage

```
docker run --rm -v /path/to/scan:/scan:ro shayanpasokhi/free-kaspersky
```
If network access is unavailable:
```
docker run --rm --network none -v /path/to/scan:/scan:ro shayanpasokhi/free-kaspersky
```

## Sample Output

```
{
  "status": true,
  "result": [
    {
      "object": "/scan/eicar.com.txt",
      "info": "EICAR-Test-File"
    },
    {
      "object": "/scan/eicar_com.zip",
      "info": "EICAR-Test-File"
    }
  ],
  "version": "24.0.5.0",
  "database": "202407280343"
}
```
## Documentation

### status

-   **Type:** Boolean
-   **Description:** Indicates whether the scan was successful.

### result

-   **Type:** Array of Objects
-   **Description:** Contains details of each detected file.
    
#### object

-   **Type:** String
-   **Description:** The path to the detected file.

#### info

-   **Type:** String
-   **Description:** Information about the detected file, typically indicating the type of threat.

### version

-   **Type:** String
-   **Description:** The version of the scan engine used.

### database

-   **Type:** String
-   **Description:** The timestamp of the database used for the scan.

### error

-   **Type:** String
-   **Description:** If an error occurred during the scan, this key will contain a description of the error.
