#17,3 -> 6,3 MB on linux with UPX, gcc, lto
#42,8 -> 6,4 MB on win with UPX
# is it possible to remove GLES2 or something?

#verbose                        = "yes" #not that useful tbh
target                         = "release"

#using the following requires libatomic.a, which isn't provided on arch linux?
#use_llvm                       = "yes"
#use_lld                        = "yes"
#but could also be used if this is uncommented
use_static_cpp                 = "yes" #in theory, this should also reduce binary size?
#tldr; i need a fucking build server, can't keep doin shit on my laptop

use_lto                        = "yes" # can only be used with gcc, only for linux
#windows throws errors

tools                          = "no"
disable_3d                     = "yes"
pulseaudio                     = "no" # should use alsa?
# disable_advanced_gui          = "no"
optimize                       = "size"
deprecated                     = "no"
minizip                        = "yes"
module_bmp_enabled             = "no"
module_bullet_enabled          = "no"
module_camera_enabled          = "no"
module_csg_enabled             = "no"
module_cvtt_enabled            = "no"
module_dds_enabled             = "no"
module_denoise_enabled         = "no"
module_enet_enabled            = "no"
module_etc_enabled             = "no"
module_fbx_enabled             = "no"
module_freetype_enabled        = "yes"
module_gdnative_enabled        = "no"
module_gdscript_enabled        = "yes"
module_gltf_enabled            = "no"
module_gdnavigation_enabled    = "no"
module_gridmap_enabled         = "no"
module_hdr_enabled             = "no"
module_jpg_enabled             = "no"
module_jsonrpc_enabled         = "no"
module_lightmapper_cpu_enabled = "no"
module_mbedtls_enabled         = "no"
module_minimp3_enabled         = "no"
module_mobile_vr_enabled       = "no"
module_mono_enabled            = "no"
module_ogg_enabled             = "no"
module_opensimplex_enabled     = "no"
module_opus_enabled            = "no"
module_pvr_enabled             = "no"
module_raycast_enabled         = "no"
module_recast_enabled          = "no"
module_regex_enabled           = "yes"
module_squish_enabled          = "no"
module_stb_vorbis_enabled      = "yes"
module_svg_enabled             = "no"
module_tga_enabled             = "no"
module_theora_enabled          = "no"
module_tinyexr_enabled         = "no"
module_upnp_enabled            = "no"
module_vhacd_enabled           = "no"
module_visual_script_enabled   = "no"
module_vorbis_enabled          = "no"
module_webm_enabled            = "no"
module_webp_enabled            = "no"
module_webrtc_enabled          = "no"
module_websocket_enabled       = "no"
module_webxr_enabled           = "no"
module_xatlas_unwrap_enabled   = "no"

touch                          = "no" #maybe only included on android platform?
debug_symbols                  = "no" #redundant?
