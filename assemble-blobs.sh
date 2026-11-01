#!/bin/bash
# Reassemble the large vendor blobs that GitHub's 100MB per-file limit forces
# us to ship split into 90MiB parts under split-blobs/.
#
# Run this once after cloning, before building.
set -e
cd "$(dirname "$0")"

verify() {
    local path=$1 expect=$2
    local got
    got=$(md5sum "proprietary/$path" | cut -d' ' -f1)
    if [ "$got" != "$expect" ]; then
        echo "ERROR: $path md5 mismatch: got $got expected $expect" >&2
        exit 1
    fi
}

if [ ! -f "proprietary/odm/etc/camera/anc_sdsr_model" ]; then
    echo "assembling odm/etc/camera/anc_sdsr_model"
    cat split-blobs/odm/etc/camera/anc_sdsr_model.part-* > "proprietary/odm/etc/camera/anc_sdsr_model"
fi
verify "odm/etc/camera/anc_sdsr_model" "2368065cd4c5eaa14e2cc6657c8544dd"
if [ ! -f "proprietary/odm/lib64/libarcsoft_raw_sr.so" ]; then
    echo "assembling odm/lib64/libarcsoft_raw_sr.so"
    cat split-blobs/odm/lib64/libarcsoft_raw_sr.so.part-* > "proprietary/odm/lib64/libarcsoft_raw_sr.so"
fi
verify "odm/lib64/libarcsoft_raw_sr.so" "9d62d1498115015ab385bb6523f7cfe8"
if [ ! -f "proprietary/odm/etc/camera/sd_unet.minn" ]; then
    echo "assembling odm/etc/camera/sd_unet.minn"
    cat split-blobs/odm/etc/camera/sd_unet.minn.part-* > "proprietary/odm/etc/camera/sd_unet.minn"
fi
verify "odm/etc/camera/sd_unet.minn" "4ac673e1907247e29f49b84168ee750e"
if [ ! -f "proprietary/odm/lib64/libarcsoft_dualcam_bokeh_image.so" ]; then
    echo "assembling odm/lib64/libarcsoft_dualcam_bokeh_image.so"
    cat split-blobs/odm/lib64/libarcsoft_dualcam_bokeh_image.so.part-* > "proprietary/odm/lib64/libarcsoft_dualcam_bokeh_image.so"
fi
verify "odm/lib64/libarcsoft_dualcam_bokeh_image.so" "fb96ee325843d862c9723254b71299e3"
if [ ! -f "proprietary/odm/lib64/libarcsoft_turbo_hdr_raw.so" ]; then
    echo "assembling odm/lib64/libarcsoft_turbo_hdr_raw.so"
    cat split-blobs/odm/lib64/libarcsoft_turbo_hdr_raw.so.part-* > "proprietary/odm/lib64/libarcsoft_turbo_hdr_raw.so"
fi
verify "odm/lib64/libarcsoft_turbo_hdr_raw.so" "3f0c38fb5bc4ffc2119266a242e45b21"
if [ ! -f "proprietary/odm/lib64/libarcsoft_pristine_resolution.so" ]; then
    echo "assembling odm/lib64/libarcsoft_pristine_resolution.so"
    cat split-blobs/odm/lib64/libarcsoft_pristine_resolution.so.part-* > "proprietary/odm/lib64/libarcsoft_pristine_resolution.so"
fi
verify "odm/lib64/libarcsoft_pristine_resolution.so" "90b4d463585b49c458c5e7efa0bb27f8"
if [ ! -f "proprietary/odm/etc/camera/aisn.bin" ]; then
    echo "assembling odm/etc/camera/aisn.bin"
    cat split-blobs/odm/etc/camera/aisn.bin.part-* > "proprietary/odm/etc/camera/aisn.bin"
fi
verify "odm/etc/camera/aisn.bin" "74af9a416a524621767b3ee8220cc001"

echo "all large blobs assembled and verified"
