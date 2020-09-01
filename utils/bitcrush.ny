;nyquist plug-in
;version 1.2
;type process
;name "bitcrush"
;action "Crushing..."
;info "dblue_crusher like bitcrusher by envyniv.\nCustomize to your liking."
;control samples "Samples" int "Samples" 1 0 100
;control depth "BitDepth" int "Bits" 1 0 32
;control vol "Volume" int "-dB" 1 0 30

;sample reduction

;desired bitdepth
(quantize s depth)

;smoothing
(loud -vol (cue sound))