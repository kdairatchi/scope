#!/bin/bash

nuclei -l recon_output/all_urls.txt -severity critical,high,medium -stats -json -o nuclei.log
