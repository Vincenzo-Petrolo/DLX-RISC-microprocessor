#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Sat Jun  4 15:42:05 2022                
#                                                     
#######################################################

#@(#)CDS: Innovus v17.11-s080_1 (64bit) 08/04/2017 11:13 (Linux 2.6.18-194.el5)
#@(#)CDS: NanoRoute 17.11-s080_1 NR170721-2155/17_11-UB (database version 2.30, 390.7.1) {superthreading v1.44}
#@(#)CDS: AAE 17.11-s034 (64bit) 08/04/2017 (Linux 2.6.18-194.el5)
#@(#)CDS: CTE 17.11-s053_1 () Aug  1 2017 23:31:41 ( )
#@(#)CDS: SYNTECH 17.11-s012_1 () Jul 21 2017 02:29:12 ( )
#@(#)CDS: CPE v17.11-s095
#@(#)CDS: IQRC/TQRC 16.1.1-s215 (64bit) Thu Jul  6 20:18:10 PDT 2017 (Linux 2.6.18-194.el5)

set_global _enable_mmmc_by_default_flow      $CTE::mmmc_default
suppressMessage ENCEXT-2799
getDrawView
loadWorkspace -name Physical
win
set defHierChar /
set delaycal_input_transition_delay 0.1ps
set fpIsMaxIoHeight 0
set init_gnd_net gnd
set init_mmmc_file Default.view
set init_oa_search_lib {}
set init_pwr_net vdd
set init_verilog DLX_postsyn.v
set init_lef_file /software/dk/nangate45/lef/NangateOpenCellLibrary.lef
set init_top_cell CPU
init_design
getIoFlowFlag
setIoFlowFlag 0
floorPlan -coreMarginsBy die -site FreePDK45_38x28_10R_NP_162NW_34O -r 1 0.6 5 5 5 5
uiSetTool select
getIoFlowFlag
fit
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
setAddRingMode -ring_target default -extend_over_row 0 -ignore_rows 0 -avoid_short 0 -skip_crossing_trunks none -stacked_via_top_layer metal10 -stacked_via_bottom_layer metal1 -via_using_exact_crossover_size 1 -orthogonal_only true -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape }
addRing -nets {gnd vdd} -type core_rings -follow core -layer {top metal9 bottom metal9 left metal10 right metal10} -width {top 0.8 bottom 0.8 left 0.8 right 0.8} -spacing {top 0.8 bottom 0.8 left 0.8 right 0.8} -offset {top 1.8 bottom 1.8 left 1.8 right 1.8} -center 1 -extend_corner {} -threshold 0 -jog_distance 0 -snap_wire_center_to_grid None
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
set sprCreateIeRingLayers {}
set sprCreateIeStripeWidth 10.0
set sprCreateIeStripeThreshold 1.0
setAddStripeMode -ignore_block_check false -break_at none -route_over_rows_only false -rows_without_stripes_only false -extend_to_closest_target none -stop_at_last_wire_for_area false -partial_set_thru_domain false -ignore_nondefault_domains false -trim_antenna_back_to_shape none -spacing_type edge_to_edge -spacing_from_block 0 -stripe_min_length 0 -stacked_via_top_layer metal10 -stacked_via_bottom_layer metal1 -via_using_exact_crossover_size false -split_vias false -orthogonal_only true -allow_jog { padcore_ring  block_ring }
addStripe -nets {vdd gnd} -layer metal10 -direction vertical -width 0.8 -spacing 0.8 -set_to_set_distance 20 -start_from left -start_offset 15 -switch_layer_over_obs false -max_same_layer_jog_length 2 -padcore_ring_top_layer_limit metal10 -padcore_ring_bottom_layer_limit metal1 -block_ring_top_layer_limit metal10 -block_ring_bottom_layer_limit metal1 -use_wire_group 0 -snap_wire_center_to_grid None -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape }
setSrouteMode -viaConnectToShape { noshape }
sroute -connect { blockPin padPin padRing corePin floatingStripe } -layerChangeRange { metal1(1) metal10(10) } -blockPinTarget { nearestTarget } -padPinPortConnect { allPort oneGeom } -padPinTarget { nearestTarget } -corePinTarget { firstAfterRowEnd } -floatingStripeTarget { blockring padring ring stripe ringpin blockpin followpin } -allowJogging 1 -crossoverViaLayerRange { metal1(1) metal10(10) } -nets { gnd vdd } -allowLayerChange 1 -blockPin useLef -targetViaLayerRange { metal1(1) metal10(10) }
setPlaceMode -prerouteAsObs {1 2 3 4 5 6 7 8}
setPlaceMode -fp false
placeDesign
setDrawView ameba
setDrawView place
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Bottom -layer 1 -spreadType center -spacing 0.14 -pin CLK
setPinAssignMode -pinEditInBatch true
editPin -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Bottom -layer 1 -spreadType center -spacing 0.14 -pin RST
setPinAssignMode -pinEditInBatch true
editPin -pinWidth 0.07 -pinDepth 0.07 -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Bottom -layer 1 -spreadType center -spacing 0.14 -pin RST
setPinAssignMode -pinEditInBatch false
setOptMode -fixCap true -fixTran true -fixFanoutLoad false
optDesign -postCTS
optDesign -postCTS -hold
getFillerMode -quiet
addFiller -cell FILLCELL_X8 FILLCELL_X4 FILLCELL_X32 FILLCELL_X2 FILLCELL_X16 FILLCELL_X1 -prefix FILLER
setNanoRouteMode -quiet -timingEngine {}
setNanoRouteMode -quiet -routeWithSiPostRouteFix 0
setNanoRouteMode -quiet -drouteStartIteration default
setNanoRouteMode -quiet -routeTopRoutingLayer default
setNanoRouteMode -quiet -routeBottomRoutingLayer default
setNanoRouteMode -quiet -drouteEndIteration default
setNanoRouteMode -quiet -routeWithTimingDriven false
setNanoRouteMode -quiet -routeWithSiDriven false
routeDesign -globalDetail
setAnalysisMode -analysisType onChipVariation
setOptMode -fixCap true -fixTran true -fixFanoutLoad false
optDesign -postRoute
optDesign -postRoute -hold
saveDesign DLX
win
set_analysis_view -setup {default} -hold {default}
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -pathReports -drvReports -slackReports -numPaths 50 -prefix CPU_postRoute -outDir timingReports
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -pathReports -slackReports -numPaths 50 -prefix CPU_postRoute_setup -outDir timingReports
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -pathReports -drvReports -slackReports -numPaths 50 -prefix CPU_postRoute_hold -outDir timingReports
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -hold -pathReports -slackReports -numPaths 50 -prefix CPU_postRoute_hold -outDir timingReports
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -pathReports -drvReports -slackReports -numPaths 50 -prefix CPU_postRoute_setup -outDir timingReports
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -hold -pathReports -slackReports -numPaths 50 -prefix CPU_postRoute_hold -outDir timingReports
reset_parasitics
extractRC
rcOut -setload CPU.setload -rc_corner high
rcOut -setres CPU.setres -rc_corner high
rcOut -spf CPU.spf -rc_corner high
rcOut -spef CPU.spef -rc_corner high
set_analysis_view -setup {default} -hold {default}
reset_parasitics
extractRC
rcOut -setload CPU.setload -rc_corner standard
rcOut -setres CPU.setres -rc_corner standard
rcOut -spf CPU.spf -rc_corner standard
rcOut -spef CPU.spef -rc_corner standard
get_time_unit
report_timing -machine_readable -max_paths 10000 -max_slack 0.75 -path_exceptions all > top.mtarpt
load_timing_debug_report -name default_report top.mtarpt
analyze_paths_by_bottleneck
analyze_paths_by_bottleneck
analyze_paths_by_bottleneck -category 10 -max_slack 0.5
analyze_paths_by_clock_domain
verifyConnectivity -type all -error 1000 -warning 50
setVerifyGeometryMode -area { 0 0 0 0 } -minWidth true -minSpacing true -minArea true -sameNet true -short true -overlap true -offRGrid false -offMGrid true -mergedMGridCheck true -minHole true -implantCheck true -minimumCut true -minStep true -viaEnclosure true -antenna false -insuffMetalOverlap true -pinInBlkg false -diffCellViol true -sameCellViol false -padFillerCellsOverlap true -routingBlkgPinOverlap true -routingCellBlkgOverlap true -regRoutingOnly false -stackedViasOnRegNet false -wireExt true -useNonDefaultSpacing false -maxWidth true -maxNonPrefLength -1 -error 1000
verifyGeometry
setVerifyGeometryMode -area { 0 0 0 0 }
reportGateCount -level 5 -limit 100 -outfile CPU.gateCount
saveNetlist DLX_postPlace&Route.v
all_hold_analysis_views 
all_setup_analysis_views 
write_sdf  -ideal_clock_network DLX.sdf
setLayerPreference powerNet -color {#FF0000 #FF1500 #FF2A00 #FF4000 #FF5500 #FF6A00 #FF8000 #FF9500 #FFA800 #FFB400 #FFBF00 #FFCB00 #FFD600 #FFE200 #FFED00 #FFF900 #EEF600 #CDE600 #ACD500 #8BC500 #6AB400 #4AA400 #299400 #088300 #007318 #006239 #00525A #00417B #00319C #0020BD #0010DE #0000FF}
set_power_rail_display -plot none
setLayerPreference powerNet -color {#ff0000 #ff1500 #ff2a00 #ff4000 #ff5500 #ff6a00 #ff8000 #ff9500 #ffa800 #ffb400 #ffbf00 #ffcb00 #ffd600 #ffe200 #ffed00 #fff900 #eef600 #cde600 #acd500 #8bc500 #6ab400 #4aa400 #299400 #088300 #007318 #006239 #00525a #00417b #00319c #0020bd #0010de #0000ff}
::fit main.layout.win
set_power_rail_display -range_min 0 -range_max 5 -filter_min 0 -filter_max 5
set_power_rail_display -plot none
setLayerPreference powerNet -color {#ff0000 #ff1500 #ff2a00 #ff4000 #ff5500 #ff6a00 #ff8000 #ff9500 #ffa800 #ffb400 #ffbf00 #ffcb00 #ffd600 #ffe200 #ffed00 #fff900 #eef600 #cde600 #acd500 #8bc500 #6ab400 #4aa400 #299400 #088300 #007318 #006239 #00525a #00417b #00319c #0020bd #0010de #0000ff}
set_power_rail_display -plot none
setLayerPreference powerNet -color {#ff0000 #ff1500 #ff2a00 #ff4000 #ff5500 #ff6a00 #ff8000 #ff9500 #ffa800 #ffb400 #ffbf00 #ffcb00 #ffd600 #ffe200 #ffed00 #fff900 #eef600 #cde600 #acd500 #8bc500 #6ab400 #4aa400 #299400 #088300 #007318 #006239 #00525a #00417b #00319c #0020bd #0010de #0000ff}
set_power_analysis_mode -reset
set_power_analysis_mode -method static -corner max -create_binary_db true -write_static_currents true -honor_negative_energy true -ignore_control_signals true
set_power_output_dir -reset
set_power_output_dir ./
set_default_switching_activity -reset
set_default_switching_activity -input_activity 0.2 -period 10.0
read_activity_file -reset
set_power -reset
set_powerup_analysis -reset
set_dynamic_power_simulation -reset
report_power -rail_analysis_format VS -outfile .//CPU.rpt
set_power_analysis_mode -reset
set_power_analysis_mode -method static -analysis_view worst -corner max -create_binary_db false -write_static_currents false -honor_negative_energy true -ignore_control_signals true
set_power_output_dir -reset
set_power_output_dir ./
set_default_switching_activity -reset
set_default_switching_activity -input_activity 0.2 -period 10.0
read_activity_file -reset
set_switching_activity -reset
set_switching_activity -activity 0.5 -pin CLK -period 1ns -duty 0.5ns
set_power -reset
set_powerup_analysis -reset
set_dynamic_power_simulation -reset
report_power -rail_analysis_format VS -outfile .//CPU.rpt
set_power_output_dir -reset
set_power_output_dir ./
set_default_switching_activity -reset
set_default_switching_activity -input_activity 0.2 -period 10.0
read_activity_file -reset
set_switching_activity -reset
set_switching_activity -activity 0.5 -pin CLK -period 0.001 -duty 0.0005
set_power -reset
set_powerup_analysis -reset
set_dynamic_power_simulation -reset
report_power -rail_analysis_format VS -outfile .//CPU.rpt
set_power_analysis_mode -reset
set_power_analysis_mode -method static -corner max -create_binary_db false -write_static_currents false -honor_negative_energy true -ignore_control_signals true
set_power_output_dir -reset
set_power_output_dir ./
set_default_switching_activity -reset
set_default_switching_activity -input_activity 0.2 -period 10.0
read_activity_file -reset
set_switching_activity -reset
set_switching_activity -activity 0.5 -pin CLK -period 0.001 -duty 0.0005
set_power -reset
set_powerup_analysis -reset
set_dynamic_power_simulation -reset
report_power -rail_analysis_format VS -outfile .//CPU.rpt
view_dynamic_movie
set_power_rail_display -plot none
setLayerPreference powerNet -color {#ff0000 #ff1500 #ff2a00 #ff4000 #ff5500 #ff6a00 #ff8000 #ff9500 #ffa800 #ffb400 #ffbf00 #ffcb00 #ffd600 #ffe200 #ffed00 #fff900 #eef600 #cde600 #acd500 #8bc500 #6ab400 #4aa400 #299400 #088300 #007318 #006239 #00525a #00417b #00319c #0020bd #0010de #0000ff}
set_power_rail_display -plot none
setLayerPreference powerNet -color {#ff0000 #ff1500 #ff2a00 #ff4000 #ff5500 #ff6a00 #ff8000 #ff9500 #ffa800 #ffb400 #ffbf00 #ffcb00 #ffd600 #ffe200 #ffed00 #fff900 #eef600 #cde600 #acd500 #8bc500 #6ab400 #4aa400 #299400 #088300 #007318 #006239 #00525a #00417b #00319c #0020bd #0010de #0000ff}
set_power_rail_display -plot none
setLayerPreference powerNet -color {#ff0000 #ff1500 #ff2a00 #ff4000 #ff5500 #ff6a00 #ff8000 #ff9500 #ffa800 #ffb400 #ffbf00 #ffcb00 #ffd600 #ffe200 #ffed00 #fff900 #eef600 #cde600 #acd500 #8bc500 #6ab400 #4aa400 #299400 #088300 #007318 #006239 #00525a #00417b #00319c #0020bd #0010de #0000ff}
set_power_rail_display -plot none
setLayerPreference powerNet -color {#ff0000 #ff1500 #ff2a00 #ff4000 #ff5500 #ff6a00 #ff8000 #ff9500 #ffa800 #ffb400 #ffbf00 #ffcb00 #ffd600 #ffe200 #ffed00 #fff900 #eef600 #cde600 #acd500 #8bc500 #6ab400 #4aa400 #299400 #088300 #007318 #006239 #00525a #00417b #00319c #0020bd #0010de #0000ff}
uiSetTool defineArea ps::measure_region
uiSetTool defineArea ps::measure_region
