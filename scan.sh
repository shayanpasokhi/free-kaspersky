#!/bin/bash

SCANNER_INFO=$(xmlstarlet sel -t -m '//root/update_info' -v "concat('\"version\":\"', @product_version, '\",\"database\":\"', @databases_timestamp, '\"')" "/opt/kvrt.xml")

json_error() {
  local error_message=$1
  echo "{\"status\":false,\"error\":\"${error_message}\",${SCANNER_INFO}}"
  exit 1
}

json_result() {
  local result_message=$1
  
  echo "{\"status\":true,\"result\":${result_message},${SCANNER_INFO}}"
  exit 0
}

/opt/kvrt.run -- -accepteula -silent -dontencrypt -customonly -custom "/scan" >/dev/null 2>&1

if [ $? -ne 0 ]; then
  json_error "Kaspersky encountered an error"
fi

REPORT_FILE=$(ls -1t /var/opt/KVRT*_Data/Reports/report_*.klr | head -n 1)

if [ ! -f "$REPORT_FILE" ]; then
  json_error "Report file not found"
fi

DETECTED=$(xmlstarlet sel -t -m '//EventBlocks/*[starts-with(name(), "Block")][@Type="Scan"]/*[starts-with(name(), "Event")][@Action="Detect"]' -v "concat('{\"object\":\"', @Object, '\",\"info\":\"', @Info, '\"}', ',')" "$REPORT_FILE" | sed '$ s/,$//')

json_result "[$DETECTED]"
