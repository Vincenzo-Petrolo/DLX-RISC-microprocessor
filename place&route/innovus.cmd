#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Wed Jun  8 00:53:29 2022                
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
addStripe -nets {gnd vdd} -layer metal10 -direction vertical -width 0.8 -spacing 0.8 -set_to_set_distance 20 -start_from left -start_offset 15 -switch_layer_over_obs false -max_same_layer_jog_length 2 -padcore_ring_top_layer_limit metal10 -padcore_ring_bottom_layer_limit metal1 -block_ring_top_layer_limit metal10 -block_ring_bottom_layer_limit metal1 -use_wire_group 0 -snap_wire_center_to_grid None -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape }
setSrouteMode -viaConnectToShape { noshape }
sroute -connect { blockPin padPin padRing corePin floatingStripe } -layerChangeRange { metal1(1) metal10(10) } -blockPinTarget { nearestTarget } -padPinPortConnect { allPort oneGeom } -padPinTarget { nearestTarget } -corePinTarget { firstAfterRowEnd } -floatingStripeTarget { blockring padring ring stripe ringpin blockpin followpin } -allowJogging 1 -crossoverViaLayerRange { metal1(1) metal10(10) } -nets { gnd vdd } -allowLayerChange 1 -blockPin useLef -targetViaLayerRange { metal1(1) metal10(10) }
setPlaceMode -prerouteAsObs {1 2 3 4 5 6 7 8}
setPlaceMode -fp false
placeDesign
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -fixOverlap 1 -unit MICRON -spreadDirection clockwise -side Bottom -layer 1 -spreadType center -spacing 0.14 -pin {WE_MEM RST RE_MEM CLK}
setPinAssignMode -pinEditInBatch false
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -fixOverlap 1 -spreadDirection clockwise -side Left -layer 1 -spreadType side -pin {{ADDR_MEM[0]} {ADDR_MEM[1]} {ADDR_MEM[2]} {ADDR_MEM[3]} {ADDR_MEM[4]} {ADDR_MEM[5]} {ADDR_MEM[6]} {ADDR_MEM[7]} {ADDR_MEM[8]} {ADDR_MEM[9]} {ADDR_MEM[10]} {ADDR_MEM[11]} {ADDR_MEM[12]} {ADDR_MEM[13]} {ADDR_MEM[14]} {ADDR_MEM[15]} {ADDR_MEM[16]} {ADDR_MEM[17]} {ADDR_MEM[18]} {ADDR_MEM[19]} {ADDR_MEM[20]} {ADDR_MEM[21]} {ADDR_MEM[22]} {ADDR_MEM[23]} {ADDR_MEM[24]} {ADDR_MEM[25]} {ADDR_MEM[26]} {ADDR_MEM[27]} {ADDR_MEM[28]} {ADDR_MEM[29]} {ADDR_MEM[30]} {ADDR_MEM[31]} {DATA_OUT_MEM[0]} {DATA_OUT_MEM[1]} {DATA_OUT_MEM[2]} {DATA_OUT_MEM[3]} {DATA_OUT_MEM[4]} {DATA_OUT_MEM[5]} {DATA_OUT_MEM[6]} {DATA_OUT_MEM[7]} {DATA_OUT_MEM[8]} {DATA_OUT_MEM[9]} {DATA_OUT_MEM[10]} {DATA_OUT_MEM[11]} {DATA_OUT_MEM[12]} {DATA_OUT_MEM[13]} {DATA_OUT_MEM[14]} {DATA_OUT_MEM[15]} {DATA_OUT_MEM[16]} {DATA_OUT_MEM[17]} {DATA_OUT_MEM[18]} {DATA_OUT_MEM[19]} {DATA_OUT_MEM[20]} {DATA_OUT_MEM[21]} {DATA_OUT_MEM[22]} {DATA_OUT_MEM[23]} {DATA_OUT_MEM[24]} {DATA_OUT_MEM[25]} {DATA_OUT_MEM[26]} {DATA_OUT_MEM[27]} {DATA_OUT_MEM[28]} {DATA_OUT_MEM[29]} {DATA_OUT_MEM[30]} {DATA_OUT_MEM[31]}}
setPinAssignMode -pinEditInBatch true
editPin -fixOverlap 1 -spreadDirection clockwise -side Top -layer 1 -spreadType side -pin {{DATA_IN_MEM[0]} {DATA_IN_MEM[1]} {DATA_IN_MEM[2]} {DATA_IN_MEM[3]} {DATA_IN_MEM[4]} {DATA_IN_MEM[5]} {DATA_IN_MEM[6]} {DATA_IN_MEM[7]} {DATA_IN_MEM[8]} {DATA_IN_MEM[9]} {DATA_IN_MEM[10]} {DATA_IN_MEM[11]} {DATA_IN_MEM[12]} {DATA_IN_MEM[13]} {DATA_IN_MEM[14]} {DATA_IN_MEM[15]} {DATA_IN_MEM[16]} {DATA_IN_MEM[17]} {DATA_IN_MEM[18]} {DATA_IN_MEM[19]} {DATA_IN_MEM[20]} {DATA_IN_MEM[21]} {DATA_IN_MEM[22]} {DATA_IN_MEM[23]} {DATA_IN_MEM[24]} {DATA_IN_MEM[25]} {DATA_IN_MEM[26]} {DATA_IN_MEM[27]} {DATA_IN_MEM[28]} {DATA_IN_MEM[29]} {DATA_IN_MEM[30]} {DATA_IN_MEM[31]}}
setPinAssignMode -pinEditInBatch true
editPin -fixOverlap 1 -spreadDirection clockwise -side Right -layer 1 -spreadType side -pin {{INSTRUCTION_IMEM[0]} {INSTRUCTION_IMEM[1]} {INSTRUCTION_IMEM[2]} {INSTRUCTION_IMEM[3]} {INSTRUCTION_IMEM[4]} {INSTRUCTION_IMEM[5]} {INSTRUCTION_IMEM[6]} {INSTRUCTION_IMEM[7]} {INSTRUCTION_IMEM[8]} {INSTRUCTION_IMEM[9]} {INSTRUCTION_IMEM[10]} {INSTRUCTION_IMEM[11]} {INSTRUCTION_IMEM[12]} {INSTRUCTION_IMEM[13]} {INSTRUCTION_IMEM[14]} {INSTRUCTION_IMEM[15]} {INSTRUCTION_IMEM[16]} {INSTRUCTION_IMEM[17]} {INSTRUCTION_IMEM[18]} {INSTRUCTION_IMEM[19]} {INSTRUCTION_IMEM[20]} {INSTRUCTION_IMEM[21]} {INSTRUCTION_IMEM[22]} {INSTRUCTION_IMEM[23]} {INSTRUCTION_IMEM[24]} {INSTRUCTION_IMEM[25]} {INSTRUCTION_IMEM[26]} {INSTRUCTION_IMEM[27]} {INSTRUCTION_IMEM[28]} {INSTRUCTION_IMEM[29]} {INSTRUCTION_IMEM[30]} {INSTRUCTION_IMEM[31]} {PC_OUT_IMEM[0]} {PC_OUT_IMEM[1]} {PC_OUT_IMEM[2]} {PC_OUT_IMEM[3]} {PC_OUT_IMEM[4]} {PC_OUT_IMEM[5]} {PC_OUT_IMEM[6]} {PC_OUT_IMEM[7]} {PC_OUT_IMEM[8]} {PC_OUT_IMEM[9]} {PC_OUT_IMEM[10]} {PC_OUT_IMEM[11]} {PC_OUT_IMEM[12]} {PC_OUT_IMEM[13]} {PC_OUT_IMEM[14]} {PC_OUT_IMEM[15]} {PC_OUT_IMEM[16]} {PC_OUT_IMEM[17]} {PC_OUT_IMEM[18]} {PC_OUT_IMEM[19]} {PC_OUT_IMEM[20]} {PC_OUT_IMEM[21]} {PC_OUT_IMEM[22]} {PC_OUT_IMEM[23]} {PC_OUT_IMEM[24]} {PC_OUT_IMEM[25]} {PC_OUT_IMEM[26]} {PC_OUT_IMEM[27]} {PC_OUT_IMEM[28]} {PC_OUT_IMEM[29]} {PC_OUT_IMEM[30]} {PC_OUT_IMEM[31]}}
setPinAssignMode -pinEditInBatch true
editPin -pinWidth 0.07 -pinDepth 0.07 -fixOverlap 1 -spreadDirection clockwise -side Right -layer 1 -spreadType side -pin {{INSTRUCTION_IMEM[0]} {INSTRUCTION_IMEM[1]} {INSTRUCTION_IMEM[2]} {INSTRUCTION_IMEM[3]} {INSTRUCTION_IMEM[4]} {INSTRUCTION_IMEM[5]} {INSTRUCTION_IMEM[6]} {INSTRUCTION_IMEM[7]} {INSTRUCTION_IMEM[8]} {INSTRUCTION_IMEM[9]} {INSTRUCTION_IMEM[10]} {INSTRUCTION_IMEM[11]} {INSTRUCTION_IMEM[12]} {INSTRUCTION_IMEM[13]} {INSTRUCTION_IMEM[14]} {INSTRUCTION_IMEM[15]} {INSTRUCTION_IMEM[16]} {INSTRUCTION_IMEM[17]} {INSTRUCTION_IMEM[18]} {INSTRUCTION_IMEM[19]} {INSTRUCTION_IMEM[20]} {INSTRUCTION_IMEM[21]} {INSTRUCTION_IMEM[22]} {INSTRUCTION_IMEM[23]} {INSTRUCTION_IMEM[24]} {INSTRUCTION_IMEM[25]} {INSTRUCTION_IMEM[26]} {INSTRUCTION_IMEM[27]} {INSTRUCTION_IMEM[28]} {INSTRUCTION_IMEM[29]} {INSTRUCTION_IMEM[30]} {INSTRUCTION_IMEM[31]} {PC_OUT_IMEM[0]} {PC_OUT_IMEM[1]} {PC_OUT_IMEM[2]} {PC_OUT_IMEM[3]} {PC_OUT_IMEM[4]} {PC_OUT_IMEM[5]} {PC_OUT_IMEM[6]} {PC_OUT_IMEM[7]} {PC_OUT_IMEM[8]} {PC_OUT_IMEM[9]} {PC_OUT_IMEM[10]} {PC_OUT_IMEM[11]} {PC_OUT_IMEM[12]} {PC_OUT_IMEM[13]} {PC_OUT_IMEM[14]} {PC_OUT_IMEM[15]} {PC_OUT_IMEM[16]} {PC_OUT_IMEM[17]} {PC_OUT_IMEM[18]} {PC_OUT_IMEM[19]} {PC_OUT_IMEM[20]} {PC_OUT_IMEM[21]} {PC_OUT_IMEM[22]} {PC_OUT_IMEM[23]} {PC_OUT_IMEM[24]} {PC_OUT_IMEM[25]} {PC_OUT_IMEM[26]} {PC_OUT_IMEM[27]} {PC_OUT_IMEM[28]} {PC_OUT_IMEM[29]} {PC_OUT_IMEM[30]} {PC_OUT_IMEM[31]}}
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
reset_parasitics
extractRC
rcOut -setload CPU.setload -rc_corner standard
rcOut -setres CPU.setres -rc_corner standard
rcOut -spf CPU.spf -rc_corner standard
rcOut -spef CPU.spef -rc_corner standard
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -pathReports -drvReports -slackReports -numPaths 50 -prefix CPU_postRoute_setup -outDir timingReports
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -hold -pathReports -slackReports -numPaths 50 -prefix CPU_postRoute_hold -outDir timingReports
get_time_unit
report_timing -machine_readable -max_paths 10000 -max_slack 0.75 -path_exceptions all > top.mtarpt
load_timing_debug_report -name default_report top.mtarpt
get_time_unit
report_timing -machine_readable -max_paths 10000 -max_slack 0.75 -path_exceptions all -early > top.mtarpt
load_timing_debug_report -name default_report top.mtarpt
verifyConnectivity -type all -error 1000 -warning 50
setVerifyGeometryMode -area { 0 0 0 0 } -minWidth true -minSpacing true -minArea true -sameNet true -short true -overlap true -offRGrid false -offMGrid true -mergedMGridCheck true -minHole true -implantCheck true -minimumCut true -minStep true -viaEnclosure true -antenna false -insuffMetalOverlap true -pinInBlkg false -diffCellViol true -sameCellViol false -padFillerCellsOverlap true -routingBlkgPinOverlap true -routingCellBlkgOverlap true -regRoutingOnly false -stackedViasOnRegNet false -wireExt true -useNonDefaultSpacing false -maxWidth true -maxNonPrefLength -1 -error 1000
verifyGeometry
setVerifyGeometryMode -area { 0 0 0 0 }
reportGateCount -level 5 -limit 100 -outfile CPU.gateCount
saveNetlist post_place_route_CPU.v
all_hold_analysis_views 
all_setup_analysis_views 
write_sdf  -ideal_clock_network CPU.sdf
set_power_analysis_mode -reset
set_power_analysis_mode -method static -corner max -create_binary_db true -write_static_currents true -honor_negative_energy true -ignore_control_signals true
set_power_output_dir -reset
set_power_output_dir ./
set_default_switching_activity -reset
set_default_switching_activity -input_activity 0.2 -period 10.0
read_activity_file -reset
set_switching_activity -reset
set_switching_activity -activity 0.5 -net CLK -period 0.001 -duty 0.5
set_power -reset
set_powerup_analysis -reset
set_dynamic_power_simulation -reset
report_power -rail_analysis_format VS -outfile .//CPU.rpt
debug_irdrop -eco_report
man debug_irdrop
debug_irdrop -eco_report -state_directory irdrop
analyze_rail
analyze_rail -type net vdd
set_rail_analysis_mode
set_rail_analysis_mode static
set_rail_analysis_mode -method static
set_rail_analysis_mode -method static -accuracy xd
set_rail_analysis_mode -method static -accuracy xd -power_grid_library
saveDesign DLX
