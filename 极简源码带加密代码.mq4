//自定义指标 =>  ...\MT4\MQL4\Indicators

////////////////////////////////////////////////////////////////////////
bool     Company_control = false;                                                      // 限制平台开关
bool     Account_Control = false;                                                      // 限制账号开关
bool     Time_Control = true;                                                          // 限制时间开关
string   Company = "";                                                                 // 平台名称
string   Bind_Account = "12345+23456+34567";                                           // 绑定真实账号
// 多个账号用+分开。举例：="12345+23456+34567";
datetime Use_Expiration_Time = D'2027.04.10 00:00:00';                                 // 使用期限
string   Company_Error_Reminder_Content = "使用平台错误,请联系...";                    // 平台错误提醒
string   Account_Error_Reminder_Content = "没有绑定该账号,请联系...";                  // 账号错误提醒
string   The_Deadline_Has_Reached_The_Reminder_Content = "使用期限已到,请联系...";     // 时间到期提醒
////////////////////////////////////////////////////////////////////////



#property  copyright "编程 EA代写：Q+452357231【需访问？请点我！】"
#property  link      "https://qm.qq.com/q/HxD8zVm6c"
#property version    "1.0"
#property strict
#property  indicator_chart_window   //主图
#property  indicator_buffers 50
#property  indicator_color1  0xFFFFFFFF
#property  indicator_color2  0xFFFFFFFF
#property  indicator_color3  0xFFFFFFFF
#property  indicator_color4  0xFFFFFFFF
#property  indicator_width5  3
#property  indicator_color5  DeepPink
#property  indicator_width6  3
#property  indicator_color6  DeepPink
#property  indicator_width7  1
#property  indicator_color7  DeepPink
#property  indicator_width8  1
#property  indicator_color8  DeepPink
#property  indicator_width9  3
#property  indicator_color9  DodgerBlue
#property  indicator_width10  3
#property  indicator_color10  DodgerBlue
#property  indicator_width11  1
#property  indicator_color11  DodgerBlue
#property  indicator_width12  1
#property  indicator_color12  DodgerBlue
#property  indicator_width13  3
#property  indicator_color13  LimeGreen
#property  indicator_width14  3
#property  indicator_color14  LimeGreen
#property  indicator_width15  1
#property  indicator_color15  LimeGreen
#property  indicator_width16  1
#property  indicator_color16  LimeGreen
#property  indicator_width17  3
#property  indicator_color17  Orange
#property  indicator_width18  3
#property  indicator_color18  Orange
#property  indicator_width19  1
#property  indicator_color19  Orange
#property  indicator_width20  1
#property  indicator_color20  Orange
#property  indicator_width21  4
#property  indicator_color21  FireBrick
#property  indicator_width22  4
#property  indicator_color22  MediumSeaGreen
#property  indicator_width23  4
#property  indicator_color23  Yellow
#property  indicator_width24  4
#property  indicator_color24  White
#property  indicator_width25  2
#property  indicator_color25  DeepPink
#property  indicator_width26  2
#property  indicator_color26  DodgerBlue
#property  indicator_width27  2
#property  indicator_color27  Yellow
#property  indicator_width28  2
#property  indicator_color28  White
#property  indicator_width29  1
#property  indicator_color29  HotPink
#property  indicator_width30  1
#property  indicator_color30  RoyalBlue
#property  indicator_width31  2
#property  indicator_color31  HotPink
#property  indicator_width32  2
#property  indicator_color32  RoyalBlue
#property  indicator_width33  1
#property  indicator_color33  LightPink
#property  indicator_width34  2
#property  indicator_color34  HotPink
#property  indicator_width35  4
#property  indicator_color35  Red
#property  indicator_width36  1
#property  indicator_color36  LightBlue
#property  indicator_width37  2
#property  indicator_color37  DodgerBlue
#property  indicator_width38  4
#property  indicator_color38  Aqua
#property  indicator_color39  Black
#property  indicator_color40  Black
#property  indicator_color41  Black
#property  indicator_color42  Black
#property  indicator_color43  Black
#property  indicator_color44  Black
#property  indicator_color45  Black
#property  indicator_color46  Black
#property  indicator_color47  Black
#property  indicator_color48  Black
#property  indicator_color49  Black
#property  indicator_color50  Black
#property description  ""
  enum ENUM_TIMEFRAMES_CUSTOM      {TF_CURRENT = 0,TF_M1 = 1,TF_M5 = 5,TF_M15 = 15,TF_M30 = 30,TF_H1 = 60,TF_H4 = 240,TF_D1 = 1440,TF_W1 = 10080,TF_MN = 43200  };


//------------------
extern string Sep3="==== 倒计时参数 ===="  ;   //分隔线
extern bool ShowCountdown=true  ;    //显示倒计时
extern string Sep4="==== 多空分水岭参数 ===="  ;   //分隔线
extern bool ShowPivot=true  ;    //显示多空分水岭
extern string Sep5="==== K线点数统计参数（智能增强版） ===="  ;  
extern bool ShowCandlePoints=false ;    //显示K线点数
extern string Sep5_3="---- 统计面板参数 ----"  ;  
extern int   StatsPanelX=1  ;    //面板X坐标
extern int   StatsPanelY=20  ;    //面板Y坐标
extern string Sep6="==== 提示信息参数 ===="  ;   //分隔线
extern bool AlertWithSound=true  ;    //声音提醒
extern string Sep7="==== 实时K线智能分析系统 ===="  ;   //分隔线
extern bool ShowLiveBarAnalysis=false ;    //显示实时K线分析面板（默认关闭，可通过按钮开启）
extern int   LiveBarPanelX=1  ;    //面板X坐标（像素）
extern int   LiveBarPanelY=20  ;    //面板Y坐标（像素）
extern int   LiveBarPanelWidth=310  ;    //面板宽度（像素，推荐250-350）
extern int   LiveBarPanelHeight=450  ;    //面板高度（像素，推荐300-400，SR显示需要更高）
extern int   LiveBarFontSize=9  ;    //面板字体大小
extern string Sep9="==== 多货币监测仪系统 ===="  ;   //分隔线
extern bool ShowCurrencyMonitor=false ;    //显示多货币监测仪（默认关闭，可通过按钮开启）
extern string CurrencyPairs="EURUSD,GBPUSD,AUDUSD,NZDUSD,USDCAD,USDCHF,USDJPY,XAUUSD"  ;   //监测货币对列表（逗号分隔）
extern bool MonitorAlertEnabled=true  ;    //启用交易信号提醒
extern int   MonitorPanelX=1  ;    //监测仪X坐标
extern int   MonitorPanelY=20  ;    //监测仪Y坐标
extern int   MonitorPanelWidth=420  ;    //监测仪宽度（像素，完美比例）
extern int   MonitorPanelHeight=310  ;    //监测仪高度（像素，已优化尺寸）
extern string Sep10="==== 右上角信息面板 ===="  ;   //分隔线
extern bool ShowTopRightInfo=true  ;    //显示右上角信息（品种+周期+北京时间）
extern int   BeijingTimeOffset=5  ;    //北京时间偏移（小时，默认+8，可根据服务器时区调整）
extern string 请用正版EA程序="QQ(VX):452357231 极简天眼指标 V11.mq4  请务必使用正版EA程序,以避免破解版带来的不稳定性和安全隐患"  ;  
extern datetime  程序最终编译时间=1770801799  ;   
  long      总_1_lo_0 = 0;
  datetime  总_2_da_8 = D'2026.02.26';
  double    总_3_do_10_ko[];
  double    总_4_do_44_ko[];
  double    总_5_do_78_ko[];
  double    总_6_do_AC_ko[];
  double    总_7_do_E0_ko[];
  double    总_8_do_114_ko[];
  double    总_9_do_148_ko[];
  double    总_10_do_17C_ko[];
  double    总_11_do_1B0_ko[];
  double    总_12_do_1E4_ko[];
  double    总_13_do_218_ko[];
  double    总_14_do_24C_ko[];
  double    总_15_do_280_ko[];
  double    总_16_do_2B4_ko[];
  double    总_17_do_2E8_ko[];
  double    总_18_do_31C_ko[];
  double    总_19_do_350_ko[];
  double    总_20_do_384_ko[];
  double    总_21_do_3B8_ko[];
  double    总_22_do_3EC_ko[];
  double    总_23_do_420_ko[];
  double    总_24_do_454_ko[];
  double    总_25_do_488_ko[];
  double    总_26_do_4BC_ko[];
  double    总_27_do_4F0_ko[];
  double    总_28_do_524_ko[];
  double    总_29_do_558_ko[];
  double    总_30_do_58C_ko[];
  double    总_31_do_5C0_ko[];
  double    总_32_do_5F4_ko[];
  double    总_33_do_628_ko[];
  double    总_34_do_65C_ko[];
  double    总_35_do_690_ko[];
  double    总_36_do_6C4_ko[];
  double    总_37_do_6F8_ko[];
  double    总_38_do_72C_ko[];
  double    总_39_do_760_ko[];
  double    总_40_do_794_ko[];
  double    总_41_do_7C8_ko[];
  double    总_42_do_7FC_ko[];
  double    总_43_do_830_ko[];
  double    总_44_do_864_ko[];
  double    总_45_do_898_ko[];
  double    总_46_do_8CC_ko[];
  double    总_47_do_900_ko[];
  double    总_48_do_934_ko[];
  double    总_49_do_968_ko[];
  double    总_50_do_99C_ko[];
  double    总_51_do_9D0_ko[];
  double    总_52_do_A04_ko[];
  string    总_53_st_A38 = "==== 授权验证参数 ====";
  bool      总_54_bo_A44 = true;
  string    总_55_st_A48 = "极简天眼指标 V11";
  int       总_56_in_A54 = 5;
  int       总_57_in_A58 = 15;
  int       总_58_in_A5C = 8;
  int       总_59_in_A60 = 1;
  uint      总_60_ui_A64 = DeepPink;
  uint      总_61_ui_A68 = Yellow;
  int       总_62_in_A6C = 46;
  int       总_63_in_A70 = 58;
  int       总_64_in_A74 = 20;
  int       总_65_in_A78 = 0;
  uint      总_66_ui_A7C = Red;
  uint      总_67_ui_A80 = LimeGreen;
  string    总_68_st_A88 = "Arial";
  bool      总_69_bo_A94 = true;
  int       总_70_in_A98 = 50;
  int       总_71_in_A9C = 20;
  double    总_72_do_AA0 = 0.5;
  double    总_73_do_AA8 = 0.3;
  int       总_74_in_AB0 = 14;
  bool      总_75_bo_AB4 = true;
  double    总_76_do_AB8 = 0.4;
  int       总_77_in_AC0 = 0;
  string    总_78_st_AC8 = "==== K线变色线宽参数 ====";
  int       总_79_in_AD4 = 3;
  int       总_80_in_AD8 = 1;
  string    总_81_st_AE0 = "==== 珠线系统参数 ====";
  int       总_82_in_AEC = 52;
  int       总_83_in_AF0 = 34;
  int       总_84_in_AF4 = 18;
  int       总_85_in_AF8 = 14;
  double    总_86_do_B00 = 0.3;
  double    总_87_do_B08 = 0.5;
  int       总_88_in_B10 = 50;
  bool      总_89_bo_B14 = true;
  bool      总_90_bo_B15 = true;
  bool      总_91_bo_B16 = true;
  string    总_92_st_B18 = "==== 6色箭头系统参数 ====";
  bool      总_93_bo_B24 = true;
  bool      总_94_bo_B25 = true;
  double    总_95_do_B28 = 0.3;
  double    总_96_do_B30 = 0.4;
  double    总_97_do_B38 = 0.5;
  int       总_98_in_B40 = 3;
  int       总_99_in_B44 = 10;
  int       总_100_in_B48 = 100;
  bool      总_101_bo_B4C = true;
  int       总_102_in_B50 = 10;
  uint      总_103_ui_B54 = Yellow;
  double    总_104_do_B58 = 1.9;
  bool      总_105_bo_B60 = true;
  bool      总_106_bo_B61 = true;
  double    总_107_do_B68 = 0.1;
  uint      总_108_ui_B70 = Yellow;
  int       总_109_in_B74 = 2;
  uint      总_110_ui_B78 = Red;
  uint      总_111_ui_B7C = Lime;
  int       总_112_in_B80 = 1;
  int       总_113_in_B84 = 1;
  int       总_114_in_B88 = 7;
  int       总_115_in_B8C = 300;
  int       总_116_in_B90 = 60;
  uint      总_117_ui_B94 = LightCoral;
  uint      总_118_ui_B98 = MediumSeaGreen;
  bool      总_119_bo_B9C = true;
  int       总_120_in_BA0 = 500;
  string    总_121_st_BA8 = "---- 智能增强功能 ----";
  bool      总_122_bo_BB4 = true;
  bool      总_123_bo_BB5 = true;
  bool      总_124_bo_BB6 = true;
  bool      总_125_bo_BB7 = true;
  bool      总_126_bo_BB8 = true;
  double    总_127_do_BC0 = 1.8;
  string    总_128_st_BC8 = "---- 波动分级颜色 ----";
  uint      总_129_ui_BD4 = DimGray;
  uint      总_130_ui_BD8 = Yellow;
  uint      总_131_ui_BDC = Orange;
  uint      总_132_ui_BE0 = Red;
  int       总_133_in_BE4 = 20;
  int       总_134_in_BE8 = 8;
  string    总_135_st_BF0 = "---- 视觉增强参数（融合方案） ----";
  bool      总_136_bo_BFC = true;
  int       总_137_in_C00 = 20;
  uint      总_138_ui_C04 = 0x37322D;
  bool      总_139_bo_C08 = true;
  bool      总_140_bo_C09 = true;
  string    总_141_st_C10 = "---- 固定颜色模式 ----";
  uint      总_142_ui_C1C = 0x342A23;
  uint      总_143_ui_C20 = 0x3E342D;
  string    总_144_st_C28 = "---- 智能趋势分析 ----";
  bool      总_145_bo_C34 = true;
  int       总_146_in_C38 = 10;
  bool      总_147_bo_C3C = true;
  bool      总_148_bo_C3D = true;
  int       总_149_in_C40 = 80;
  string    总_150_st_C48 = "---- 交易决策辅助 ----";
  bool      总_151_bo_C54 = true;
  double    总_152_do_C58 = 1.5;
  bool      总_153_bo_C60 = true;
  bool      总_154_bo_C61 = true;
  bool      总_155_bo_C62 = false;
  bool      总_156_bo_C63 = true;
  bool      总_157_bo_C64 = true;
  int       总_158_in_C68 = 3;
  bool      总_159_bo_C6C = true;
  bool      总_160_bo_C6D = true;
  bool      总_161_bo_C6E = true;
  int       总_162_in_C70 = 16;
  string    总_163_st_C78 = "---- 实时分析配色（极简+情绪）----";
  bool      总_164_bo_C84 = true;
  int       总_165_in_C88 = 15;
  bool      总_166_bo_C8C = true;
  string    总_167_st_C90 = "---- 固定颜色模式 ----";
  uint      总_168_ui_C9C = 0x37322D;
  uint      总_169_ui_CA0 = 0x342A23;
  uint      总_170_ui_CA4 = 0x3E342D;
  uint      总_171_ui_CA8 = 0x5F5046;
  string    总_172_st_CB0 = "---- 文字配色（三级层次）----";
  uint      总_173_ui_CBC = 0xF0EBE6;
  uint      总_174_ui_CC0 = 0xC8BEB4;
  uint      总_175_ui_CC4 = 0xA09182;
  string    总_176_st_CC8 = "---- 涨跌配色（柔和护眼）----";
  uint      总_177_ui_CD4 = 0x6464FF;
  uint      总_178_ui_CD8 = 0x78C864;
  uint      总_179_ui_CDC = 0x5050C8;
  uint      总_180_ui_CE0 = 0x64A050;
  string    总_181_st_CE8 = "==== 动态智能支撑阻力位系统（智能增强版） ====";
  bool      总_182_bo_CF4 = true;
  int       总_183_in_CF8 = 14;
  double    总_184_do_D00 = 1.0;
  double    总_185_do_D08 = 0.5;
  string    总_186_st_D10 = "---- 智能颜色分级系统 ----";
  uint      总_187_ui_D1C = MediumSeaGreen;
  uint      总_188_ui_D20 = LightGreen;
  uint      总_189_ui_D24 = PaleGreen;
  uint      总_190_ui_D28 = DodgerBlue;
  uint      总_191_ui_D2C = LightSkyBlue;
  uint      总_192_ui_D30 = PowderBlue;
  uint      总_193_ui_D34 = Gold;
  uint      总_194_ui_D38 = Magenta;
  string    总_195_st_D40 = "---- 多层雷达感应 ----";
  int       总_196_in_D4C = 2;
  double    总_197_do_D50 = 0.5;
  double    总_198_do_D58 = 1.0;
  double    总_199_do_D60 = 1.5;
  int       总_200_in_D68 = 1;
  int       总_201_in_D6C = 1;
  int       总_202_in_D70 = 1;
  double    总_203_do_D78 = 5.0;
  double    总_204_do_D80 = 20.0;
  string    总_205_st_D88 = "---- 增强标签系统 ----";
  bool      总_206_bo_D94 = true;
  bool      总_207_bo_D95 = true;
  bool      总_208_bo_D96 = true;
  bool      总_209_bo_D97 = true;
  int       总_210_in_D98 = 7;
  double    总_211_do_DA0 = 5.0;
  bool      总_212_bo_DA8 = false;
  string    总_213_st_DB0 = "---- 智能预警系统 ----";
  bool      总_214_bo_DBC = false;
  int       总_215_in_DC0 = 2;
  bool      总_216_bo_DC4 = true;
  bool      总_217_bo_DC5 = true;
  string    总_218_st_DC8 = "---- 高级功能 ----";
  bool      总_219_bo_DD4 = true;
  bool      总_220_bo_DD5 = true;
  bool      总_221_bo_DD6 = true;
  bool      总_222_bo_DD7 = true;
  int       总_223_in_DD8 = 5;
  int       总_224_in_DDC = 300;
  bool      总_225_bo_DE0 = true;
  int       总_226_in_DE4 = 8;
  uint      总_227_ui_DE8 = 0x1E1919;
  uint      总_228_ui_DEC = 0x372D28;
  uint      总_229_ui_DF0 = Red;
  uint      总_230_ui_DF4 = LimeGreen;
  uint      总_231_ui_DF8 = 0x505050;
  int       总_232_in_DFC = 60;
  bool      总_233_bo_E00 = false;
  int       总_234_in_E04 = 0;
  datetime  总_235_lo_E08 = 0;
  bool      总_236_bo_E10 = false;
  datetime  总_237_lo_E18 = 0;
  int       总_238_in_E20 = -1;
  datetime  总_239_lo_E28 = 0;
  double    总_240_do_E30 = 0.0;
  double    总_241_do_E38 = 0.0;
  double    总_242_do_E40 = 0.0;
  datetime  总_243_lo_E48 = 0;
  double    总_244_do_E84_si20[20];
  int       总_245_in_F24 = 0;
  double    总_246_do_F28 = 0.0;
  double    总_247_do_F30 = 0.0;
  double    总_248_do_F38 = 0.0;
  double    总_249_do_F40 = 0.0;
  double    总_250_do_F48 = 1.0;
  int       总_251_in_F50 = 5;
  int       总_252_in_F54 = 0;
  datetime  总_253_da_F58 = 0;
  double    总_254_do_F94_si7[7];
  string    总_255_st_1000_si7[7]={"SR_Center" , "SR_R1" , "SR_R2" , "SR_R3" , "SR_S1" , "SR_S2" , "SR_S3"} ;
  color     总_256_co_1088_si7[7];
  int       总_257_in_10D8_si7[7];
  datetime  总_258_da_1128_si7[7];
  bool      总_259_bo_1194_si7[7];
  int       总_260_in_119C_ko[];
  int       总_261_in_11D0 = 0;
  int       总_262_in_1208_si7[7];
  int       总_263_in_1224 = -1;
  int       总_264_in_125C_si7[7];
  datetime  总_265_da_12AC_si7[7];
  bool      总_266_bo_1318_si7[7];
  int       总_267_in_1354_si7[7];
  datetime  总_268_da_13A4_si7[7];
  int       总_269_in_1410_si7[7];
  bool      总_270_bo_1460_si7[7];
  int       总_271_in_149C_si7[7];
  int       总_272_in_14B8 = 3;
  double    总_273_do_14C0 = 34.0;
  bool      总_274_bo_14C8 = false;
  string    总_275_st_14CC_ko[];
  int       总_276_in_1500 = 0;
  int       总_277_in_1504_ko[];
  long      总_278_lo_1538 = 0;
  datetime  总_279_lo_1540 = 0;
  int       总_280_in_1548_ko[];
  datetime  总_281_da_157C_ko[];
  color     总_282_co_15E4_si7[7]={255 , 17919 , 55295 , 65280 , 16776960 , 16711680 , 16711935} ;
  int       总_283_in_1600 = 0;
  int       总_284_in_1604 = 0;
  bool      总_285_bo_1608 = false;
  datetime  总_286_da_1610 = 0;
  int       总_287_in_1618 = 0;
  uint      总_288_ui_161C = Red;
  uint      总_289_ui_1620 = DeepPink;
  bool      总_290_bo_1624 = true;
  int       总_291_in_1628 = 0;
  bool      总_292_bo_162C = true;
  int       总_293_in_1630 = 0;
  datetime  总_294_da_1638 = 0;
  int       总_295_in_1640 = 2;
  string    总_296_st_1678_si3[3]={};
  int       总_297_in_169C = 0;
  datetime  总_298_da_16A0 = 0;
  int       总_299_in_16A8 = 59;
  int       总_300_in_16AC = 0;
  long      总_301_lo_16B0 = 0;


 int OnInit()
 { 
  int       子_3_in;
  int       子_4_in;
  int       子_5_in;
  string    子_6_st;
  long      子_7_lo;
//----- -----
 int        临_in_1;
 int        临_in_2;


 if ( 总_54_bo_A44 )
 {
  /* if ( ( TimeCurrent() >= D'2026.02.27' || TimeLocal() >  D'2026.02.27' ) )
   {
     Alert("已到期"); 
     ExpertRemove(); 
   }
   子_2_st = WindowExpertName() ;
   if ( ( TimeCurrent() >= D'2026.03.01' || TimeLocal() >  D'2026.03.01' ) )
   {
     Alert("已到期"); 
     ExpertRemove(); 
   }
   if ( 子_2_st != 总_55_st_A48 )
   {
     if ( ( TimeCurrent() >= D'2026.03.12' || TimeLocal() >  D'2026.03.12' ) )
     {
       Alert("已到期"); 
       ExpertRemove(); 
     }
     Print("╚══════════════════════ ╝"); 
     if ( ( TimeCurrent() >= D'2026.03.23' || TimeLocal() >  D'2026.03.23' ) )
     {
       Alert("已到期"); 
       ExpertRemove(); 
     }
     Print("║ 联系方式: QQ(VX): 452357231          ║"); 
     if ( ( TimeCurrent() >= D'2026.03.05' || TimeLocal() >  D'2026.03.05' ) )
     {
       Alert("已到期"); 
       ExpertRemove(); 
     }
     Print("║ 此指标名称不符，请联系很无邪            ║"); 
     Print("║ ---------------------------------------- ║"); 
     Print("║ 授权标识: ",总_55_st_A48); 
     Print("║ 当前指标名称: ",子_2_st); 
     Print("╠══════════════════════ ╣"); 
     Print("║授权验证失败 -Authorization Failed║"); 
     Print("╔══════════════════════ ╗"); 
     Alert("【授权验证失败】\n\n","此指标名称不符合授权要求！\n\n","当前指标: ",子_2_st,"\n","授权标识: ",总_55_st_A48,"\n\n","请联系很无邪 QQ: 452357231"); 
     ObjectsDeleteAll(ChartID(),-1,-1); 
     ChartIndicatorDelete(ChartID(),0,WindowExpertName()); 
     return(1); 
   }
   
   Print("╚══════════════════════════ ╝"); 
   if ( ( TimeCurrent() >= D'2026.03.27' || TimeLocal() >  D'2026.03.27' ) )
   {
     Alert("已到期"); 
     ExpertRemove(); 
   }*/
   Print("║          技术支持: QQ: 452357231            ║"); 
   Print("║          欢迎使用: ",总_55_st_A48); 
   
   Print("╠══════════════════════════ ╣"); 
   Print("║ 授权验证通过 - Authorization Successful ║"); 
   Print("╔══════════════════════════ ╗"); 
 }

 SetIndexBuffer(0,总_3_do_10_ko); 
 
 SetIndexBuffer(1,总_4_do_44_ko); 
 
 SetIndexBuffer(2,总_5_do_78_ko); 
 
 SetIndexBuffer(3,总_6_do_AC_ko); 
 
 if ( 总_79_in_AD4 <  1 )
 {
   临_in_1 = 1;
 }
 else
 {
   临_in_1 = (总_79_in_AD4 >  5) ?5:总_79_in_AD4 ;
 }
 子_3_in = 临_in_1 ;
 
 if ( 总_80_in_AD8 <  1 )
 {
   临_in_2 = 1;
 }
 else
 {
   临_in_2 = (总_80_in_AD8 >  3) ?3:总_80_in_AD8 ;
 }
 子_4_in = 临_in_2 ;
 
 
 SetIndexBuffer(4,总_7_do_E0_ko); 
 SetIndexStyle(4,DRAW_HISTOGRAM,STYLE_SOLID,子_3_in,DeepPink); 
 
 SetIndexBuffer(5,总_8_do_114_ko); 
 SetIndexStyle(5,DRAW_HISTOGRAM,STYLE_SOLID,子_3_in,DeepPink); 
 
 SetIndexBuffer(6,总_9_do_148_ko); 
 
 SetIndexStyle(6,DRAW_HISTOGRAM,STYLE_SOLID,子_4_in,DeepPink); 
 
 SetIndexBuffer(7,总_10_do_17C_ko); 
 SetIndexStyle(7,DRAW_HISTOGRAM,STYLE_SOLID,子_4_in,DeepPink); 
 

 SetIndexBuffer(8,总_11_do_1B0_ko); 
 SetIndexStyle(8,DRAW_HISTOGRAM,STYLE_SOLID,子_3_in,DodgerBlue); 
 
 SetIndexBuffer(9,总_12_do_1E4_ko); 
 
 SetIndexStyle(9,DRAW_HISTOGRAM,STYLE_SOLID,子_3_in,DodgerBlue); 
 SetIndexBuffer(10,总_13_do_218_ko); 

 SetIndexStyle(10,DRAW_HISTOGRAM,STYLE_SOLID,子_4_in,DodgerBlue); 
 SetIndexBuffer(11,总_14_do_24C_ko); 

 SetIndexStyle(11,DRAW_HISTOGRAM,STYLE_SOLID,子_4_in,DodgerBlue); 
 
 SetIndexBuffer(12,总_15_do_280_ko); 
 SetIndexStyle(12,DRAW_HISTOGRAM,STYLE_SOLID,子_3_in,LimeGreen); 
 
 SetIndexBuffer(13,总_16_do_2B4_ko); 
 SetIndexStyle(13,DRAW_HISTOGRAM,STYLE_SOLID,子_3_in,LimeGreen); 

 SetIndexBuffer(14,总_17_do_2E8_ko); 
 
 SetIndexStyle(14,DRAW_HISTOGRAM,STYLE_SOLID,子_4_in,LimeGreen); 
 
 SetIndexBuffer(15,总_18_do_31C_ko); 
 SetIndexStyle(15,DRAW_HISTOGRAM,STYLE_SOLID,子_4_in,LimeGreen); 
 
 SetIndexBuffer(16,总_19_do_350_ko); 
 SetIndexStyle(16,DRAW_HISTOGRAM,STYLE_SOLID,子_3_in,Orange); 
 
 SetIndexBuffer(17,总_20_do_384_ko); 
 
 SetIndexStyle(17,DRAW_HISTOGRAM,STYLE_SOLID,子_3_in,Orange); 
 SetIndexBuffer(18,总_21_do_3B8_ko); 

 SetIndexStyle(18,DRAW_HISTOGRAM,STYLE_SOLID,子_4_in,Orange); 
 SetIndexBuffer(19,总_22_do_3EC_ko); 
 
 SetIndexStyle(19,DRAW_HISTOGRAM,STYLE_SOLID,子_4_in,Orange); 

 SetIndexBuffer(20,总_23_do_420_ko); 
 SetIndexStyle(20,DRAW_ARROW); 
 
 SetIndexArrow(20,159); 
 
 SetIndexBuffer(21,总_24_do_454_ko); 
 SetIndexStyle(21,DRAW_ARROW); 
 SetIndexArrow(21,159); 
 
 SetIndexBuffer(22,总_25_do_488_ko); 
 
 SetIndexStyle(22,DRAW_ARROW); 
 SetIndexArrow(22,159); 
 
 SetIndexBuffer(23,总_26_do_4BC_ko); 
 SetIndexStyle(23,DRAW_ARROW); 
 
 SetIndexArrow(23,159); 
 
 SetIndexBuffer(24,总_27_do_4F0_ko); 
 
 SetIndexStyle(24,DRAW_ARROW); 
 SetIndexArrow(24,159); 
 SetIndexBuffer(25,总_28_do_524_ko); 
 
 SetIndexStyle(25,DRAW_ARROW); 
 SetIndexArrow(25,159); 
 
 SetIndexBuffer(26,总_29_do_558_ko); 
 SetIndexStyle(26,DRAW_ARROW); 

 SetIndexArrow(26,159); 
 
 SetIndexBuffer(27,总_30_do_58C_ko); 
 
 SetIndexStyle(27,DRAW_ARROW); 
 SetIndexArrow(27,159); 
 
 SetIndexBuffer(28,总_31_do_5C0_ko); 
 
 SetIndexStyle(28,DRAW_ARROW); 
 SetIndexArrow(28,108); 
 
 SetIndexBuffer(29,总_32_do_5F4_ko); 
 
 SetIndexStyle(29,DRAW_ARROW); 
 SetIndexArrow(29,108); 
 
 SetIndexBuffer(30,总_33_do_628_ko); 
 
 SetIndexStyle(30,DRAW_LINE,STYLE_SOLID,2,HotPink); 
 
 SetIndexBuffer(31,总_34_do_65C_ko); 
 
 SetIndexStyle(31,DRAW_LINE,STYLE_SOLID,2,RoyalBlue); 
 
 SetIndexBuffer(32,总_35_do_690_ko); 
 
 SetIndexStyle(32,DRAW_ARROW); 
 SetIndexArrow(32,221); 
 
 SetIndexBuffer(33,总_36_do_6C4_ko); 
 
 SetIndexStyle(33,DRAW_ARROW); 
 SetIndexArrow(33,233); 
 
 SetIndexBuffer(34,总_37_do_6F8_ko); 
 
 SetIndexStyle(34,DRAW_ARROW); 
 SetIndexArrow(34,217); 
 
 SetIndexBuffer(35,总_38_do_72C_ko); 
 
 SetIndexStyle(35,DRAW_ARROW); 
 SetIndexArrow(35,222); 
 
 SetIndexBuffer(36,总_39_do_760_ko); 
 
 SetIndexStyle(36,DRAW_ARROW); 
 SetIndexArrow(36,234); 
 
 SetIndexBuffer(37,总_40_do_794_ko); 
 
 SetIndexStyle(37,DRAW_ARROW); 
 SetIndexArrow(37,218); 
 
 
 SetIndexBuffer(38,总_41_do_7C8_ko); 
 SetIndexStyle(38,DRAW_NONE); 
 
 SetIndexBuffer(39,总_42_do_7FC_ko); 
 
 SetIndexStyle(39,DRAW_NONE); 
 
 SetIndexBuffer(40,总_43_do_830_ko); 
 SetIndexStyle(40,DRAW_NONE); 
 
 SetIndexBuffer(41,总_44_do_864_ko); 
 SetIndexStyle(41,DRAW_NONE); 
 
 
 SetIndexBuffer(42,总_45_do_898_ko); 
 SetIndexStyle(42,DRAW_NONE); 
 
 SetIndexBuffer(43,总_46_do_8CC_ko); 
 SetIndexStyle(43,DRAW_NONE); 
 
 SetIndexBuffer(44,总_47_do_900_ko); 
 SetIndexStyle(44,DRAW_NONE); 
 
 SetIndexBuffer(45,总_48_do_934_ko); 
 
 SetIndexStyle(45,DRAW_NONE); 
 
 SetIndexBuffer(46,总_49_do_968_ko); 
 SetIndexStyle(46,DRAW_NONE); 
 
 SetIndexBuffer(47,总_50_do_99C_ko); 
 SetIndexStyle(47,DRAW_NONE); 
 
 SetIndexBuffer(48,总_51_do_9D0_ko); 
 
 SetIndexStyle(48,DRAW_NONE); 
 
 SetIndexBuffer(49,总_52_do_A04_ko); 
 SetIndexStyle(49,DRAW_NONE); 
 
 ArraySetAsSeries (总_3_do_10_ko,true);

 ArraySetAsSeries (总_4_do_44_ko,true);
 
 ArraySetAsSeries (总_5_do_78_ko,true);
 ArraySetAsSeries (总_6_do_AC_ko,true);
 ArraySetAsSeries (总_7_do_E0_ko,true);
 ArraySetAsSeries (总_8_do_114_ko,true);
 ArraySetAsSeries (总_9_do_148_ko,true);
 ArraySetAsSeries (总_10_do_17C_ko,true);
 ArraySetAsSeries (总_11_do_1B0_ko,true);
 ArraySetAsSeries (总_12_do_1E4_ko,true);
 ArraySetAsSeries (总_13_do_218_ko,true);
 ArraySetAsSeries (总_14_do_24C_ko,true);
 ArraySetAsSeries (总_15_do_280_ko,true);
 ArraySetAsSeries (总_16_do_2B4_ko,true);
 ArraySetAsSeries (总_17_do_2E8_ko,true);
 ArraySetAsSeries (总_18_do_31C_ko,true);
 ArraySetAsSeries (总_19_do_350_ko,true);
 ArraySetAsSeries (总_20_do_384_ko,true);
 ArraySetAsSeries (总_21_do_3B8_ko,true);
 ArraySetAsSeries (总_22_do_3EC_ko,true);
 ArraySetAsSeries (总_23_do_420_ko,true);
 ArraySetAsSeries (总_24_do_454_ko,true);
 ArraySetAsSeries (总_25_do_488_ko,true);
 ArraySetAsSeries (总_26_do_4BC_ko,true);
 ArraySetAsSeries (总_27_do_4F0_ko,true);
 ArraySetAsSeries (总_28_do_524_ko,true);
 ArraySetAsSeries (总_29_do_558_ko,true);
 ArraySetAsSeries (总_30_do_58C_ko,true);
 ArraySetAsSeries (总_31_do_5C0_ko,true);
 ArraySetAsSeries (总_32_do_5F4_ko,true);
 ArraySetAsSeries (总_33_do_628_ko,true);
 ArraySetAsSeries (总_34_do_65C_ko,true);
 ArraySetAsSeries (总_35_do_690_ko,true);
 ArraySetAsSeries (总_36_do_6C4_ko,true);
 ArraySetAsSeries (总_37_do_6F8_ko,true);
 ArraySetAsSeries (总_38_do_72C_ko,true);
 ArraySetAsSeries (总_39_do_760_ko,true);
 ArraySetAsSeries (总_40_do_794_ko,true);
 ArraySetAsSeries (总_41_do_7C8_ko,true);
 ArraySetAsSeries (总_42_do_7FC_ko,true);
 ArraySetAsSeries (总_43_do_830_ko,true);
 ArraySetAsSeries (总_44_do_864_ko,true);
 ArraySetAsSeries (总_45_do_898_ko,true);
 ArraySetAsSeries (总_46_do_8CC_ko,true);
 ArraySetAsSeries (总_47_do_900_ko,true);
 ArraySetAsSeries (总_48_do_934_ko,true);
 ArraySetAsSeries (总_49_do_968_ko,true);
 ArraySetAsSeries (总_50_do_99C_ko,true);
 ArraySetAsSeries (总_51_do_9D0_ko,true);
 ArraySetAsSeries (总_52_do_A04_ko,true);
 SetIndexLabel(0,"Signal1_Buy"); 
 SetIndexLabel(1,"Signal1_Sell"); 
 SetIndexLabel(2,"Signal2_Buy"); 
 SetIndexLabel(3,"Signal2_Sell"); 
 SetIndexLabel(4,"StrongBull_Body_High"); 
 SetIndexLabel(5,"StrongBull_Body_Low"); 
 SetIndexLabel(6,"StrongBull_Shadow_High"); 
 SetIndexLabel(7,"StrongBull_Shadow_Low"); 
 SetIndexLabel(8,"WeakBull_Body_High"); 
 SetIndexLabel(9,"WeakBull_Body_Low"); 
 SetIndexLabel(10,"WeakBull_Shadow_High"); 
 SetIndexLabel(11,"WeakBull_Shadow_Low"); 
 SetIndexLabel(12,"StrongBear_Body_High"); 
 SetIndexLabel(13,"StrongBear_Body_Low"); 
 SetIndexLabel(14,"StrongBear_Shadow_High"); 
 SetIndexLabel(15,"StrongBear_Shadow_Low"); 
 SetIndexLabel(16,"WeakBear_Body_High"); 
 SetIndexLabel(17,"WeakBear_Body_Low"); 
 SetIndexLabel(18,"WeakBear_Shadow_High"); 
 SetIndexLabel(19,"WeakBear_Shadow_Low"); 
 SetIndexLabel(20,"MainLine_Red"); 
 SetIndexLabel(21,"MainLine_Green"); 
 SetIndexLabel(22,"MainLine_Yellow"); 
 SetIndexLabel(23,"MainLine_White"); 
 SetIndexLabel(24,"AuxLine_Pink"); 
 SetIndexLabel(25,"AuxLine_Blue"); 
 SetIndexLabel(26,"AuxLine_Yellow"); 
 SetIndexLabel(27,"AuxLine_White"); 
 SetIndexLabel(28,"ThirdLine_Pink"); 
 SetIndexLabel(29,"ThirdLine_Blue"); 
 SetIndexLabel(30,"ThirdLine_Pink_Line"); 
 SetIndexLabel(31,"ThirdLine_Blue_Line"); 
 SetIndexLabel(32,"Arrow_SmallPink"); 
 SetIndexLabel(33,"Arrow_LightPink"); 
 SetIndexLabel(34,"Arrow_Red"); 
 SetIndexLabel(35,"Arrow_SmallBlue"); 
 SetIndexLabel(36,"Arrow_LightBlue"); 
 SetIndexLabel(37,"Arrow_Cyan"); 
 SetIndexLabel(38,"TrendStrength"); 
 SetIndexLabel(39,"CandleScore"); 
 SetIndexLabel(40,"SignalConfidence"); 
 SetIndexLabel(41,"VolatilityLevel"); 
 SetIndexLabel(42,"PivotPoint"); 
 SetIndexLabel(43,"NearestSR"); 
 SetIndexLabel(44,"SRDistance"); 
 SetIndexLabel(45,"SRStrength"); 
 SetIndexLabel(46,"ArrowSignal"); 
 SetIndexLabel(47,"BeadStatus"); 
 SetIndexLabel(48,"EMADistance"); 
 SetIndexLabel(49,"MarketPhase"); 
 SetIndexEmptyValue(0,0.0); 
 SetIndexEmptyValue(1,0.0); 
 SetIndexEmptyValue(2,0.0); 
 SetIndexEmptyValue(3,0.0); 
 SetIndexEmptyValue(4,INT_MAX); 
 SetIndexEmptyValue(5,INT_MAX); 
 SetIndexEmptyValue(6,INT_MAX); 
 SetIndexEmptyValue(7,INT_MAX); 
 SetIndexEmptyValue(8,INT_MAX); 
 SetIndexEmptyValue(9,INT_MAX); 
 SetIndexEmptyValue(10,INT_MAX); 
 SetIndexEmptyValue(11,INT_MAX); 
 SetIndexEmptyValue(12,INT_MAX); 
 SetIndexEmptyValue(13,INT_MAX); 
 SetIndexEmptyValue(14,INT_MAX); 
 SetIndexEmptyValue(15,INT_MAX); 
 SetIndexEmptyValue(16,INT_MAX); 
 SetIndexEmptyValue(17,INT_MAX); 
 SetIndexEmptyValue(18,INT_MAX); 
 SetIndexEmptyValue(19,INT_MAX); 
 SetIndexEmptyValue(20,INT_MAX); 
 SetIndexEmptyValue(21,INT_MAX); 
 SetIndexEmptyValue(22,INT_MAX); 
 SetIndexEmptyValue(23,INT_MAX); 
 SetIndexEmptyValue(24,INT_MAX); 
 SetIndexEmptyValue(25,INT_MAX); 
 SetIndexEmptyValue(26,INT_MAX); 
 SetIndexEmptyValue(27,INT_MAX); 
 SetIndexEmptyValue(28,INT_MAX); 
 SetIndexEmptyValue(29,INT_MAX); 
 SetIndexEmptyValue(30,INT_MAX); 
 SetIndexEmptyValue(31,INT_MAX); 
 SetIndexEmptyValue(32,INT_MAX); 
 SetIndexEmptyValue(33,INT_MAX); 
 SetIndexEmptyValue(34,INT_MAX); 
 SetIndexEmptyValue(35,INT_MAX); 
 SetIndexEmptyValue(36,INT_MAX); 
 SetIndexEmptyValue(37,INT_MAX); 
 SetIndexEmptyValue(38,0.0); 
 SetIndexEmptyValue(39,0.0); 
 SetIndexEmptyValue(40,0.0); 
 SetIndexEmptyValue(41,0.0); 
 SetIndexEmptyValue(42,0.0); 
 SetIndexEmptyValue(43,0.0); 
 SetIndexEmptyValue(44,0.0); 
 SetIndexEmptyValue(45,0.0); 
 SetIndexEmptyValue(46,0.0); 
 SetIndexEmptyValue(47,0.0); 
 SetIndexEmptyValue(48,0.0); 
 SetIndexEmptyValue(49,0.0); 
 for (子_5_in=ObjectsTotal(-1) - 1 ; 子_5_in >= 0 ; 子_5_in --)
 {
   子_6_st = ObjectName(子_5_in) ;
   if ( ( StringFind(子_6_st,"EMA1_",0) == 0 || StringFind(子_6_st,"EMA2_",0) == 0 || StringFind(子_6_st,"Countdown_",0) == 0 || StringFind(子_6_st,"Pivot_",0) == 0 || StringFind(子_6_st,"Arrow_Buy_",0) == 0 || StringFind(子_6_st,"Arrow_Sell_",0) == 0 || StringFind(子_6_st,"CandlePoints_",0) == 0 || StringFind(子_6_st,"ToggleBtn_",0) == 0 || StringFind(子_6_st,"SR_",0) == 0 || StringFind(子_6_st,"TopRight_",0) == 0 ) )
   {
     ObjectDelete(子_6_st); 
   }
 }
 
 总_233_bo_E00 = ShowCandlePoints ;
 
 总_234_in_E04 = (总_116_in_B90 == 0) ?_Period:总_116_in_B90  ;
 
 总_236_bo_E10 = ShowLiveBarAnalysis ;
 
 总_256_co_1088_si7[0] = (color)总_193_ui_D34;
 
 总_256_co_1088_si7[1] = (color)总_190_ui_D28;

 总_256_co_1088_si7[2] = (color)总_191_ui_D2C;

 总_256_co_1088_si7[3] = (color)总_192_ui_D30;
 
 总_256_co_1088_si7[4] = (color)总_187_ui_D1C;
 
 总_256_co_1088_si7[5] = (color)总_188_ui_D20;
 
 总_256_co_1088_si7[6] = (color)总_189_ui_D24;
 
 总_263_in_1224 = -1 ;
 
 
 ArrayInitialize(总_257_in_10D8_si7,0); 
 
 ArrayInitialize(总_258_da_1128_si7,0); 
 
 ArrayInitialize(总_259_bo_1194_si7,false); 
 
 ArrayResize(总_260_in_119C_ko,7,0); 

 ArrayInitialize(总_260_in_119C_ko,-1); 
 
 总_261_in_11D0 = 0 ;
 
 ArrayInitialize(总_262_in_1208_si7,0); 
 

 ArrayInitialize(总_264_in_125C_si7,0); 

 ArrayInitialize(总_265_da_12AC_si7,0); 
 
 ArrayInitialize(总_266_bo_1318_si7,false); 
 
 ArrayInitialize(总_267_in_1354_si7,0); 

 ArrayInitialize(总_268_da_13A4_si7,0); 
 
 ArrayInitialize(总_269_in_1410_si7,0); 
 
 ArrayInitialize(总_270_bo_1460_si7,false); 
 
 ArrayInitialize(总_271_in_149C_si7,0); 

 
 ArrayInitialize(总_244_do_E84_si20,0.0); 
 
 总_245_in_F24 = 0 ;
 
 总_240_do_E30 = 0.0 ;
 
 总_241_do_E38 = 0.0 ;
 
 总_242_do_E40 = 0.0 ;
 
 总_239_lo_E28 = 0 ;
 
 总_243_lo_E48 = 0 ;
 
 
 总_274_bo_14C8 = ShowCurrencyMonitor ;
 
 lizong_25(); 
 
 lizong_9(); 
 
 lizong_12(); 
 
 lizong_26(); 
 
 子_7_lo = ChartID() ;
 
 ChartSetInteger(子_7_lo,40,0x1); 
 
 ChartSetInteger(子_7_lo,1,0); 
 
 ChartSetInteger(子_7_lo,0,0x1); 
 
 ChartSetInteger(子_7_lo,2,0x1); 
 
 ChartSetInteger(子_7_lo,4,0x1); 
 
 ChartSetInteger(子_7_lo,17,0,0); 
 
 
 lizong_43(); 
 
 总_288_ui_161C = 总_282_co_15E4_si7[0] ;
 
 总_289_ui_1620 = 总_282_co_15E4_si7[0] ;
 
 总_296_st_1678_si3[0] = "作者QQ(VX):452357231 ";
 
 总_296_st_1678_si3[1] = "极简智能分析系统";
 
 总_296_st_1678_si3[2] = "极简天眼 · 智能交易";
 
 总_297_in_169C = 0 ;
 
 总_298_da_16A0 = TimeCurrent() ;
 
 
 lizong_44(); 
 
 EventSetMillisecondTimer(100); 
 
 return(0); 
 }
//OnInit <<==--------   --------
 void OnTimer()
 {
   if(UseCheck() == false)
     {
      return ;
     }
  int       子_1_in;
  int       子_2_in;
  int       子_3_in;
  bool      子_4_bo;
  bool      子_5_bo;
  bool      子_6_bo;
  double    子_7_do;
  double    子_8_do;
  int       子_9_in;
  double    子_10_do;
  color     子_11_co_si7[7]={255 , 17919 , 55295 , 65280 , 16776960 , 16711680 , 16711935} ;
  int       子_12_in;
  int       子_13_in;
  uint      子_14_ui;
  uint      子_15_ui;
  int       子_16_in;
  int       子_17_in;
  int       子_18_in;
  int       子_19_in;
  int       子_20_in;
  int       子_21_in;
  double    子_22_do;
  int       子_23_in;
  int       子_24_in;
  int       子_25_in;
  double    子_26_do;
  int       子_27_in;
  string    子_28_st;
  long      子_29_lo;
//----- -----
 double     临_do_1;
 int        临_in_2;

 
 if ( 总_285_bo_1608 )
 {
   
   子_1_in = (int)(TimeCurrent() - 总_286_da_1610);
   
   if ( 子_1_in >= 3 )
   {
    
     总_285_bo_1608 = false ;
     总_290_bo_1624 = true ;
   }
   else
   {
    
     子_2_in=(int)((TimeCurrent() - 总_286_da_1610) * 0xA % 3);
     
     总_290_bo_1624 = 子_2_in<2 ;
     if ( 总_290_bo_1624 )
     {
       if ( 总_287_in_1618 >  0 )
       {
         总_288_ui_161C = Lime ;
         总_289_ui_1620 = SpringGreen ;
       }
       else
       {
         if ( 总_287_in_1618 <  0 )
         {
           总_288_ui_161C = Red ;
           总_289_ui_1620 = OrangeRed ;
         }
       }
     }
     else
     {
       总_288_ui_161C = DarkGray ;
       总_289_ui_1620 = DarkGray ;
     }
     lizong_44(); 
     return;
   }
 }
 
 if ( TimeCurrent() - 总_294_da_1638 >= 0xA )
 {
   
   总_294_da_1638 = TimeCurrent() ;
   
   子_3_in = 0 ;
   子_4_bo=总_23_do_420_ko[子_3_in]!=INT_MAX;
   子_5_bo=总_24_do_454_ko[子_3_in]!=INT_MAX;
   子_6_bo=总_26_do_4BC_ko[子_3_in]!=INT_MAX;
   子_7_do = iATR(NULL,0,14,0) ;
   子_8_do = 0.0 ;
   for (子_9_in = 0 ; 子_9_in < 14 ; 子_9_in ++)
   {
     子_8_do = 子_8_do + iATR(NULL,0,14,子_9_in) ;
   }
   子_8_do = 子_8_do / 14.0 ;
   if ( 子_8_do>0.0 )
   {
     临_do_1 = 子_7_do / 子_8_do;
   }
   else
   {
     临_do_1 = 1.0;
   }
   子_10_do = 临_do_1 ;
   if ( 子_10_do>1.2 )
   {
     总_295_in_1640 = 3 ;
   }
   else
   {
     if ( 子_10_do>0.8 )
     {
       总_295_in_1640 = 2 ;
     }
     else
     {
       总_295_in_1640 = 1 ;
     }
   }
   if ( 子_4_bo )
   {
     总_293_in_1630 = 1 ;
   }
   else
   {
     if ( 子_5_bo )
     {
       总_293_in_1630 = 2 ;
     }
     else
     {
       if ( 子_6_bo )
       {
         总_293_in_1630 = 3 ;
       }
       else
       {
         总_293_in_1630 = 0 ;
       }
     }
   }
 }


 if ( 总_293_in_1630 == 1 )
 {
  
   子_11_co_si7[0] = Red;
   子_11_co_si7[1] = OrangeRed;
   子_11_co_si7[2] = Orange;
   
   子_11_co_si7[3] = Gold;
   子_11_co_si7[4] = Yellow;
   子_11_co_si7[5] = Orange;
   子_11_co_si7[6] = OrangeRed;
 }
 else
 {
   if ( 总_293_in_1630 == 2 )
   {
     
     子_11_co_si7[0] = Lime;
     子_11_co_si7[1] = Aqua;
     子_11_co_si7[2] = DodgerBlue;
     
     子_11_co_si7[3] = Blue;
     子_11_co_si7[4] = MediumPurple;
     子_11_co_si7[5] = Aqua;
     子_11_co_si7[6] = Lime;
   }
   else
   {
     if ( 总_293_in_1630 == 3 )
     {
      
       子_11_co_si7[0] = White;
       子_11_co_si7[1] = Silver;
       子_11_co_si7[2] = Gray;
       
       子_11_co_si7[3] = DarkGray;
       子_11_co_si7[4] = Gray;
       子_11_co_si7[5] = Silver;
       子_11_co_si7[6] = White;
     }
   }
 }
 
 总_284_in_1604 +=总_295_in_1640;
 
 if ( 总_284_in_1604 >= 100 )
 {
   
   总_284_in_1604 = 0 ;
  
   总_283_in_1600 ++;
   if ( 总_283_in_1600 >= 7 )
   {
    
     总_283_in_1600 = 0 ;
   }
 }

 子_12_in = 总_283_in_1600 ;
 
 子_13_in=(子_12_in + 1) % 7;
 
 子_14_ui = 子_11_co_si7[子_12_in] ;
 
 子_15_ui = 子_11_co_si7[子_13_in] ;
 
 子_16_in=(int)((子_14_ui >> 16) & Red);
 
 子_17_in=(int)((子_14_ui >> 8) & Red);
 
 子_18_in=(int)(子_14_ui & Red);
 
 子_19_in=(int)((子_15_ui >> 16) & Red);
 
 子_20_in=(int)((子_15_ui >> 8) & Red);
 
 子_21_in=(int)(子_15_ui & Red);
 
 子_22_do = 总_284_in_1604 / 100.0 ;
 
 子_23_in = (int)(子_16_in + (子_19_in - 子_16_in) * 子_22_do);
 
 子_24_in = (int)(子_17_in + (子_20_in - 子_17_in) * 子_22_do);
 
 子_25_in = (int)(子_18_in + (子_21_in - 子_18_in) * 子_22_do);

 
 if ( 总_292_bo_162C )
 {
   临_in_2 = 3;
 }
 else
 {
   临_in_2 = -3;
 }
 总_291_in_1628 +=临_in_2;

 if ( 总_291_in_1628 >= 100 )
 {
 
   总_291_in_1628 = 100 ;
   
   总_292_bo_162C = false ;
 }
 else
 {
   if ( 总_291_in_1628 <= 0 )
   {
    
     总_291_in_1628 = 0 ;
     
     总_292_bo_162C = true ;
   }
 }

 子_26_do = 总_291_in_1628 / 100.0 * 0.3 + 0.7 ;
 
 子_23_in = (int)(子_23_in * 子_26_do);
 
 子_24_in = (int)(子_24_in * 子_26_do);

 子_25_in = (int)(子_25_in * 子_26_do);

 if ( 子_23_in >  255 )
 {
   子_23_in = 255 ;
 }
 if ( 子_23_in <  0 )
 {
   子_23_in = 0 ;
 }

 if ( 子_24_in >  255 )
 {
   子_24_in = 255 ;
 }
 if ( 子_24_in <  0 )
 {
   子_24_in = 0 ;
 }
 
 
 if ( 子_25_in >  255 )
 {
   子_25_in = 255 ;
 }
 if ( 子_25_in <  0 )
 {
   子_25_in = 0 ;
 }
 
 
 总_288_ui_161C=(子_23_in << 16) | (子_24_in << 8) | 子_25_in;
 
 总_289_ui_1620 = 总_288_ui_161C ;

 子_27_in = (int)(TimeCurrent() - 总_298_da_16A0);
 
 if ( 子_27_in >= 总_299_in_16A8 )
 {
   
   总_297_in_169C ++;
   
   if ( 总_297_in_169C >= 3 )
   {
    
     总_297_in_169C = 0 ;
   }
  
   总_298_da_16A0 = TimeCurrent() ;
 }
 
 lizong_44(); 
 
 
 子_28_st = "VolWarning_Flash" ;
 
 if ( ObjectFind(子_28_st) != -1 )
 {
   
   子_29_lo = ObjectGetInteger(0,子_28_st,OBJPROP_TIME,0) ;
  
   if ( 子_29_lo == 0 )
   {
   
     ObjectSetInteger(0,子_28_st,OBJPROP_TIME,TimeCurrent()); 
   }
   else
   {
     if ( TimeCurrent() - 子_29_lo >= 0x3 )
     {
      
       ObjectDelete(子_28_st); 
     }
   }
 }
 
 if ( 总_252_in_F54 != 0 )
 {
   if ( ObjectFind("VolStats_Panel_BG") == -1 )
   {
     总_252_in_F54 = 0 ;
   }
   else
   {
     if ( GetTickCount() - 总_301_lo_16B0 >  0x12C )
     {
       总_301_lo_16B0 = GetTickCount() ;
       switch(总_252_in_F54)
       {
         case 1 :
         ObjectSetInteger(0,"VolStats_Panel_BG",OBJPROP_BORDER_COLOR,0xFF); 
         总_252_in_F54 = 2 ;
           break;
         case 2 :
         ObjectSetInteger(0,"VolStats_Panel_BG",OBJPROP_BORDER_COLOR,0xFFFF); 
         总_252_in_F54 = 3 ;
           break;
         case 3 :
         ObjectSetInteger(0,"VolStats_Panel_BG",OBJPROP_BORDER_COLOR,0xFF); 
         总_252_in_F54 = 4 ;
           break;
         case 4 :
         ObjectSetInteger(0,"VolStats_Panel_BG",OBJPROP_BORDER_COLOR,0xFFFF); 
         总_252_in_F54 = 5 ;
           break;
         case 5 :
         ObjectSetInteger(0,"VolStats_Panel_BG",OBJPROP_BORDER_COLOR,0x808080); 
         总_252_in_F54 = 0 ;
       }
     }
   }
 }
 }
//OnTimer <<==--------   --------
 void OnChartEvent( const int 木_0_in,const long & 木_1_lo,const double & 木_2_do,const string & 木_3_st)
 {
   if(UseCheck() == false)
     {
      return ;
     }
  int       子_1_in;
  string    子_2_st;
//----- -----
 string     临_st_1;
 string     临_st_2;
 string     临_st_3;
 string     临_st_4;
 int        临_in_5;
 string     临_st_6;
 long       临_lo_7;
 bool       临_bo_8;

 lizong_43(); 
 if ( 木_0_in != 1 )   return;
 
 if ( 木_3_st == "ToggleBtn_CandlePoints" )
 {
   总_233_bo_E00=!(总_233_bo_E00);
   if ( ObjectFind("ToggleBtn_CandlePoints") != -1 )
   {
     ObjectSetInteger(0,"ToggleBtn_CandlePoints",OBJPROP_BGCOLOR,(总_233_bo_E00) ?Goldenrod:0x40342D ); 
     if ( 总_233_bo_E00 )
     {
       临_st_1 = "点数统计 [ON]";
     }
     else
     {
       临_st_1 = "点数统计 [OFF]";
     }
     ObjectSetString(0,"ToggleBtn_CandlePoints",OBJPROP_TEXT,临_st_1); 
   }
   ObjectSetInteger(0,木_3_st,OBJPROP_STATE,0); 
   ChartRedraw(0); 
   return;
 }
 if ( 木_3_st == "ToggleBtn_LiveBar" )
 {
   总_236_bo_E10=!(总_236_bo_E10);
  
   if ( ObjectFind("ToggleBtn_LiveBar") != -1 )
   {
     
     ObjectSetInteger(0,"ToggleBtn_LiveBar",OBJPROP_BGCOLOR,(总_236_bo_E10) ?0xC4BF00:0x40342D ); 
     if ( 总_236_bo_E10 )
     {
       临_st_2 = "实时分析 [ON]";
     }
     else
     {
       临_st_2 = "实时分析 [OFF]";
     }
    
   }
   ObjectSetInteger(0,木_3_st,OBJPROP_STATE,0); 
   ChartRedraw(0); 
   return;
 }
 if ( 木_3_st == "ToggleBtn_Monitor" )
 {
   总_274_bo_14C8=!(总_274_bo_14C8);
   if ( ObjectFind("ToggleBtn_Monitor") != -1 )
   {
     ObjectSetInteger(0,"ToggleBtn_Monitor",OBJPROP_BGCOLOR,(总_274_bo_14C8) ?DarkOrange:0x40342D ); 
     if ( 总_274_bo_14C8 )
     {
       临_st_3 = "货币监测 [ON]";
     }
     else
     {
       临_st_3 = "货币监测 [OFF]";
     }
     ObjectSetString(0,"ToggleBtn_Monitor",OBJPROP_TEXT,临_st_3); 
   }
   if ( !(总_274_bo_14C8) )
   {
     for (子_1_in=ObjectsTotal(-1) - 1 ; 子_1_in >= 0 ; 子_1_in --)
     {
       子_2_st = ObjectName(子_1_in) ;
       if ( StringFind(子_2_st,"Monitor_",0) == 0 )
       {
         ObjectDelete(子_2_st); 
       }
     }
   }
   ObjectSetInteger(0,木_3_st,OBJPROP_STATE,0); 
   ChartRedraw(0); 
   return;
 }
 if ( StringFind(木_3_st,"Monitor_Symbol_",0) != 0 )   return;
 临_st_4 = 木_3_st;
 if ( !(总_225_bo_DE0) || StringLen(临_st_4)  <= 15 )   return;
 临_in_5 = (int)StringToInteger(StringSubstr(临_st_4,15,0));
 if ( 临_in_5 < 0 || 临_in_5 >= 总_276_in_1500 || 临_in_5 >= ArraySize(总_275_st_14CC_ko) )   return;
 临_st_6 = 总_275_st_14CC_ko[临_in_5];
 临_lo_7 = ChartFirst();
 临_bo_8 = false;
 while (临_lo_7 >= 0)
 {
   if ( ChartSymbol(临_lo_7) == 临_st_6 )
   {
     ChartSetSymbolPeriod(临_lo_7,临_st_6,ChartPeriod(临_lo_7)); 
     临_bo_8 = true;
     break;
   }
   临_lo_7 = ChartNext(临_lo_7);
 }
 if ( !(临_bo_8) )
 {
   if ( ChartSetSymbolPeriod(0,临_st_6,Period()) )
   {
     Print("已切换到货币对: ",临_st_6); 
     return;
   }
   Print("切换货币对失败: ",临_st_6," 请检查该货币对是否存在于市场报价中"); 
   return;
 }
 Print("已定位到货币对图表: ",临_st_6); 
 }
//OnChartEvent <<==--------   --------
 int OnCalculate( const int 木_0_in,const int 木_1_in,const datetime & 木_2_da_ko[],const double & 木_3_do_ko[],const double & 木_4_do_ko[],const double & 木_5_do_ko[],const double & 木_6_do_ko[],const long & 木_7_lo_ko[],const long & 木_8_lo_ko[],const int & 木_9_in_ko[])
 {
  long      子_2_lo;
  int       子_3_in;
  int       子_4_in;
  int       子_5_in;
  int       子_6_in;
  int       子_7_in;
  int       子_8_in;
  double    子_9_do;
  double    子_10_do;
  double    子_11_do;
  double    子_12_do;
  string    子_13_st;
  string    子_14_st;
  string    子_15_st;
  double    子_16_do;
  string    子_17_st;
  string    子_18_st;
  double    子_19_do;
  string    子_20_st;
  double    子_21_do;
  double    子_22_do;
  double    子_23_do;
  double    子_24_do;
  string    子_25_st;
  string    子_26_st;
  string    子_27_st;
  double    子_28_do;
  string    子_29_st;
  double    子_30_do;
  bool      子_31_bo;
  bool      子_32_bo;
  double    子_33_do;
  double    子_34_do;
  int       子_35_in;
  int       子_36_in;
  double    子_37_do;
  double    子_38_do;
  double    子_39_do;
  double    子_40_do;
  double    子_41_do;
  double    子_42_do;
  int       子_43_in;
  double    子_44_do;
  int       子_45_in;
  double    子_46_do;
  int       子_47_in;
  bool      子_48_bo;
  bool      子_49_bo;
  bool      子_50_bo;
  int       子_51_in;
  int       子_52_in;
  bool      子_53_bo;
  bool      子_54_bo;
  int       子_55_in;
  int       子_56_in;
  bool      子_57_bo;
  double    子_58_do;
  double    子_59_do;
  double    子_60_do;
  double    子_61_do;
  double    子_62_do;
  double    子_63_do;
  int       子_64_in;
  double    子_65_do;
  int       子_66_in;
  double    子_67_do;
  int       子_68_in;
  bool      子_69_bo;
  bool      子_70_bo;
  int       子_71_in;
  int       子_72_in;
  bool      子_73_bo;
  bool      子_74_bo;
  int       子_75_in;
  int       子_76_in;
  bool      子_77_bo;
  double    子_78_do;
  double    子_79_do;
  double    子_80_do;
  bool      子_81_bo;
  bool      子_82_bo;
  bool      子_83_bo;
  bool      子_84_bo;
  double    子_85_do;
  bool      子_86_bo;
  bool      子_87_bo;
  bool      子_88_bo;
  bool      子_89_bo;
  bool      子_90_bo;
  bool      子_91_bo;
  bool      子_92_bo;
  bool      子_93_bo;
  bool      子_94_bo;
  bool      子_95_bo;
  bool      子_96_bo;
  bool      子_97_bo;
  bool      子_98_bo;
  bool      子_99_bo;
  bool      子_100_bo;
  bool      子_101_bo;
  int       子_102_in;
  int       子_103_in;
  bool      子_104_bo;
  double    子_105_do;
  double    子_106_do;
  double    子_107_do;
  double    子_108_do;
  bool      子_109_bo;
  bool      子_110_bo;
  bool      子_111_bo;
  int       子_112_in;
  bool      子_113_bo;
  bool      子_114_bo;
  int       子_115_in;
  bool      子_116_bo;
  bool      子_117_bo;
  bool      子_118_bo;
  int       子_119_in;
  bool      子_120_bo;
  bool      子_121_bo;
  int       子_122_in;
  bool      子_123_bo;
  double    子_124_do;
  double    子_125_do;
  uint      子_126_ui;
  string    子_127_st;
  bool      子_128_bo;
  double    子_129_do;
  double    子_130_do;
  uint      子_131_ui;
  string    子_132_st;
  double    子_133_do;
  double    子_134_do;
  double    子_135_do;
  datetime  子_136_da;
  int       子_137_in;
  long      子_138_lo;
  datetime  子_139_da;
  int       子_140_in;
  string    子_141_st;
  uint      子_142_ui;
  int       子_143_in;
  double    子_144_do;
  int       子_145_in;
  int       子_146_in;
  int       子_147_in;
  int       子_148_in;
  int       子_149_in;
  int       子_150_in;
  int       子_151_in;
  int       子_152_in;
  int       子_153_in;
  int       子_154_in;
  int       子_155_in;
  int       子_156_in;
  int       子_157_in;
  int       子_158_in;
  int       子_159_in;
  int       子_160_in;
  double    子_161_do;
  double    子_162_do;
  double    子_163_do;
  double    子_164_do;
  double    子_165_do;
  double    子_166_do;
  datetime  子_167_da;
  string    子_168_st;
  string    子_169_st;
  int       子_170_in;
  datetime  子_171_da;
  bool      子_172_bo;
  double    子_173_do;
  double    子_174_do;
  double    子_175_do;
  int       子_176_in;
  double    子_177_do;
  double    子_178_do;
  double    子_179_do;
  double    子_180_do;
  double    子_181_do;
  double    子_182_do;
  double    子_183_do;
  double    子_184_do;
  double    子_185_do;
  int       子_186_in;
  string    子_187_st;
  int       子_188_in;
  int       子_189_in;
  int       子_190_in;
  datetime  子_191_da;
  double    子_192_do;
  double    子_193_do;
  double    子_194_do;
  double    子_195_do;
  bool      子_196_bo;
  double    子_197_do;
  int       子_198_in;
  string    子_199_st;
  datetime  子_200_da;
  int       子_201_in;
  int       子_202_in;
  string    子_203_st;
  int       子_204_in;
  string    子_205_st;
  bool      子_206_bo;
  bool      子_207_bo;
  string    子_208_st;
  int       子_209_in;
  datetime  子_210_da;
  double    子_211_do;
  int       子_212_in;
  datetime  子_213_da;
  int       子_214_in;
  double    子_215_do;
  double    子_216_do;
  double    子_217_do;
  double    子_218_do;
  double    子_219_do;
  double    子_220_do;
  string    子_221_st;
  int       子_222_in_si5[5]={1 , 5 , 15 , 60 , 240} ;
//----- -----
 double     临_do_1;
 double     临_do_2;
 double     临_do_3;
 double     临_do_4;
 double     临_do_5;
 double     临_do_6;
 double     临_do_7;
 double     临_do_8;
 double     临_do_9;
 double     临_do_10;
 double     临_do_11;
 double     临_do_12;
 double     临_do_13;
 double     临_do_14;
 double     临_do_15;
 double     临_do_16;
 double     临_do_17;
 int        临_in_18;
 int        临_in_19;
 double     临_do_20;
 int        临_in_21;
 int        临_in_22;
 int        临_in_23;
 double     临_do_24;
 int        临_in_25;
 int        临_in_26;
 int        临_in_27;
 long       临_lo_28;
 double     临_do_29;
 int        临_in_30;
 int        临_in_31;
 double     临_do_32;
 bool       临_bo_33;
 int        临_in_34;
 double     临_do_35;
 int        临_in_36;
 double     临_do_37;
 double     临_do_38;
 int        临_in_39;
 double     临_do_40;
 int        临_in_41;
 string     临_st_42;
 long       临_lo_43;
 uint       临_ui_44;
 string     临_st_45;
 string     临_st_46;
 long       临_lo_47;
 int        临_in_48;
 string     临_st_49;
 int        临_in_50;
 int        临_in_51;

 子_2_lo = AccountInfoInteger(ACCOUNT_LOGIN) ;
 
 
 
 ArraySetAsSeries (木_2_da_ko,true);
 
 ArraySetAsSeries (木_3_do_ko,true);
 
 ArraySetAsSeries (木_4_do_ko,true);
 
 ArraySetAsSeries (木_5_do_ko,true);
 ArraySetAsSeries (木_6_do_ko,true);
 
 子_3_in = MathMax(总_57_in_A58,总_63_in_A70) ;

 if ( 木_0_in <  子_3_in + 2 )
 {
   return(0); 
 }

 if ( 木_1_in == 0 )
 {
  
   ArrayInitialize(总_3_do_10_ko,0.0); 
   ArrayInitialize(总_4_do_44_ko,0.0); 
  
   ArrayInitialize(总_5_do_78_ko,0.0); 
   
   ArrayInitialize(总_6_do_AC_ko,0.0); 
   
   ArrayInitialize(总_7_do_E0_ko,INT_MAX); 
   ArrayInitialize(总_8_do_114_ko,INT_MAX); 
   
   ArrayInitialize(总_9_do_148_ko,INT_MAX); 
   
   ArrayInitialize(总_10_do_17C_ko,INT_MAX); 
   
   ArrayInitialize(总_11_do_1B0_ko,INT_MAX); 
   ArrayInitialize(总_12_do_1E4_ko,INT_MAX); 
   
   ArrayInitialize(总_13_do_218_ko,INT_MAX); 
   ArrayInitialize(总_14_do_24C_ko,INT_MAX); 
   
   ArrayInitialize(总_15_do_280_ko,INT_MAX); 
   
   ArrayInitialize(总_16_do_2B4_ko,INT_MAX); 
   ArrayInitialize(总_17_do_2E8_ko,INT_MAX); 
   
   ArrayInitialize(总_18_do_31C_ko,INT_MAX); 
   ArrayInitialize(总_19_do_350_ko,INT_MAX); 
   
   ArrayInitialize(总_20_do_384_ko,INT_MAX); 
  
   ArrayInitialize(总_21_do_3B8_ko,INT_MAX); 
   ArrayInitialize(总_22_do_3EC_ko,INT_MAX); 
   
   ArrayInitialize(总_23_do_420_ko,INT_MAX); 
   
   ArrayInitialize(总_24_do_454_ko,INT_MAX); 
   
   ArrayInitialize(总_25_do_488_ko,INT_MAX); 
   
   ArrayInitialize(总_26_do_4BC_ko,INT_MAX); 
   ArrayInitialize(总_27_do_4F0_ko,INT_MAX); 
   
   ArrayInitialize(总_28_do_524_ko,INT_MAX); 
   ArrayInitialize(总_29_do_558_ko,INT_MAX); 
   
   ArrayInitialize(总_30_do_58C_ko,INT_MAX); 
   ArrayInitialize(总_31_do_5C0_ko,INT_MAX); 
   ArrayInitialize(总_32_do_5F4_ko,INT_MAX); 
   ArrayInitialize(总_35_do_690_ko,INT_MAX); 
   ArrayInitialize(总_36_do_6C4_ko,INT_MAX); 
   ArrayInitialize(总_37_do_6F8_ko,INT_MAX); 
   ArrayInitialize(总_38_do_72C_ko,INT_MAX); 
   ArrayInitialize(总_39_do_760_ko,INT_MAX); 
   ArrayInitialize(总_40_do_794_ko,INT_MAX); 
   ArrayInitialize(总_41_do_7C8_ko,0.0); 
   ArrayInitialize(总_42_do_7FC_ko,0.0); 
   ArrayInitialize(总_43_do_830_ko,0.0); 
   ArrayInitialize(总_44_do_864_ko,0.0); 
   ArrayInitialize(总_45_do_898_ko,0.0); 
   ArrayInitialize(总_46_do_8CC_ko,0.0); 
   ArrayInitialize(总_47_do_900_ko,0.0); 
   ArrayInitialize(总_48_do_934_ko,0.0); 
   ArrayInitialize(总_49_do_968_ko,0.0); 
   ArrayInitialize(总_50_do_99C_ko,0.0); 
   ArrayInitialize(总_51_do_9D0_ko,0.0); 
   ArrayInitialize(总_52_do_A04_ko,0.0); 
 }
 
 子_4_in = 0 ;
 
 if ( 木_1_in == 0 )
 {
   
   子_4_in=木_0_in - 子_3_in - 1;
 }
 else
 {
   
   子_4_in=木_0_in - 木_1_in + 1;
 }
 
 
 子_5_in = (总_77_in_AC0 == 1) ?1:0  ;
 
 for (子_6_in = 子_4_in ; 子_6_in >= 子_5_in ; 子_6_in --)
 {
   
   子_7_in = 子_6_in ;
   
   子_8_in=子_6_in + 1;
   
   
   if ( 子_8_in <  木_0_in )
   {
     
     子_9_do = iMA(NULL,0,总_56_in_A54,0,1,0,子_7_in) ;
     
     子_10_do = iMA(NULL,0,总_57_in_A58,0,1,0,子_7_in) ;
     
    
     子_11_do = iMA(NULL,0,总_56_in_A54,0,1,0,子_8_in) ;
     
     子_12_do = iMA(NULL,0,总_57_in_A58,0,1,0,子_8_in) ;
     
     
     子_13_st = (总_59_in_A60 == 0) ?"D":"b1"  ;
     
     子_14_st = (总_59_in_A60 == 0) ?"K":"s1"  ;
     
     if ( 子_11_do<=子_12_do && 子_9_do>子_10_do )
     {
       
       总_3_do_10_ko[子_7_in] = 1.0;
       
       总_4_do_44_ko[子_7_in] = 0.0;
       
       if ( 子_7_in == 0 )
       {
         
         总_285_bo_1608 = true ;
         
         总_286_da_1610 = TimeCurrent() ;
         
         总_287_in_1618 = 1 ;
       }
      
       子_15_st="EMA1_UP_" + IntegerToString(木_2_da_ko[子_7_in],0,32);
       
       if ( ObjectFind(子_15_st) == -1 )
       {
         
         if ( !(总_69_bo_A94) )
         {
           临_do_1 = 总_70_in_A98 * Point;
         }
         else
         {
           if ( iATR(NULL,0,总_74_in_AB0,子_7_in)<=0.0 )
           {
             if ( 1 == 1 )
             {
               临_do_1 = 总_70_in_A98 * Point;
             }
             else
             {
               临_do_1 = 总_71_in_A9C * Point;
             }
           }
           else
           {
             临_do_2 = 0.0;
             if ( 1 == 1 )
             {
               临_do_2 = iATR(NULL,0,总_74_in_AB0,子_7_in) * 总_72_do_AA0;
             }
             else
             {
               临_do_2 = iATR(NULL,0,总_74_in_AB0,子_7_in) * 总_73_do_AA8;
             }
             临_do_1 = 临_do_2;
           }
         }
         子_16_do = 临_do_1 ;
         
         子_17_st = 子_13_st + " " + DoubleToString(木_6_do_ko[子_7_in],Digits) ;
         
         ObjectCreate(0,子_15_st,OBJ_TEXT,0,木_2_da_ko[子_7_in],木_5_do_ko[子_7_in] - 子_16_do); 
         
         ObjectSetString(0,子_15_st,OBJPROP_TEXT,子_17_st); 
        
         ObjectSetInteger(0,子_15_st,OBJPROP_FONTSIZE,总_58_in_A5C); 
         
         ObjectSetString(0,子_15_st,OBJPROP_FONT,总_68_st_A88); 
         
         ObjectSetInteger(0,子_15_st,OBJPROP_COLOR,总_60_ui_A64); 
       }
     }
     
     else
     {
       if ( 子_11_do>=子_12_do && 子_9_do<子_10_do )
       {
         总_4_do_44_ko[子_7_in] = 1.0;
         总_3_do_10_ko[子_7_in] = 0.0;
         if ( 子_7_in == 0 )
         {
           总_285_bo_1608 = true ;
           总_286_da_1610 = TimeCurrent() ;
           总_287_in_1618 = -1 ;
         }
         子_18_st="EMA1_DN_" + IntegerToString(木_2_da_ko[子_7_in],0,32);
         if ( ObjectFind(子_18_st) == -1 )
         {
           if ( !(总_69_bo_A94) )
           {
             临_do_3 = 总_70_in_A98 * Point;
           }
           else
           {
             if ( iATR(NULL,0,总_74_in_AB0,子_7_in)<=0.0 )
             {
               if ( 1 == 1 )
               {
                 临_do_3 = 总_70_in_A98 * Point;
               }
               else
               {
                 临_do_3 = 总_71_in_A9C * Point;
               }
             }
             else
             {
               临_do_4 = 0.0;
               if ( 1 == 1 )
               {
                 临_do_4 = iATR(NULL,0,总_74_in_AB0,子_7_in) * 总_72_do_AA0;
               }
               else
               {
                 临_do_4 = iATR(NULL,0,总_74_in_AB0,子_7_in) * 总_73_do_AA8;
               }
               临_do_3 = 临_do_4;
             }
           }
           子_19_do = 临_do_3 ;
           子_20_st = 子_14_st + " " + DoubleToString(木_6_do_ko[子_7_in],Digits) ;
           ObjectCreate(0,子_18_st,OBJ_TEXT,0,木_2_da_ko[子_7_in],木_4_do_ko[子_7_in] + 子_19_do); 
           ObjectSetString(0,子_18_st,OBJPROP_TEXT,子_20_st); 
           ObjectSetInteger(0,子_18_st,OBJPROP_FONTSIZE,总_58_in_A5C); 
           ObjectSetString(0,子_18_st,OBJPROP_FONT,总_68_st_A88); 
           ObjectSetInteger(0,子_18_st,OBJPROP_COLOR,总_61_ui_A68); 
         }
       }
       else
       {
         if ( 木_1_in == 0 )
         {
           总_3_do_10_ko[子_7_in] = 0.0;
           总_4_do_44_ko[子_7_in] = 0.0;
         }
       }
     }
     
     子_21_do = iMA(NULL,0,总_62_in_A6C,0,1,0,子_7_in) ;
     子_22_do = iMA(NULL,0,总_63_in_A70,0,1,0,子_7_in) ;
     
     子_23_do = iMA(NULL,0,总_62_in_A6C,0,1,0,子_8_in) ;
     子_24_do = iMA(NULL,0,总_63_in_A70,0,1,0,子_8_in) ;
     
     子_25_st = (总_65_in_A78 == 0) ?"D":"b2"  ;
     子_26_st = (总_65_in_A78 == 0) ?"K":"s2"  ;
     if ( 子_23_do<=子_24_do && 子_21_do>子_22_do )
     {
       总_5_do_78_ko[子_7_in] = 1.0;
       总_6_do_AC_ko[子_7_in] = 0.0;
       if ( 子_7_in == 0 )
       {
         总_285_bo_1608 = true ;
         总_286_da_1610 = TimeCurrent() ;
         总_287_in_1618 = 1 ;
       }
       子_27_st="EMA2_UP_" + IntegerToString(木_2_da_ko[子_7_in],0,32);
       if ( ObjectFind(子_27_st) == -1 )
       {
         if ( !(总_69_bo_A94) )
         {
           临_do_5 = 总_71_in_A9C * Point;
         }
         else
         {
           if ( iATR(NULL,0,总_74_in_AB0,子_7_in)<=0.0 )
           {
             if ( 2 == 1 )
             {
               临_do_5 = 总_70_in_A98 * Point;
             }
             else
             {
               临_do_5 = 总_71_in_A9C * Point;
             }
           }
           else
           {
             临_do_6 = 0.0;
             if ( 2 == 1 )
             {
               临_do_6 = iATR(NULL,0,总_74_in_AB0,子_7_in) * 总_72_do_AA0;
             }
             else
             {
               临_do_6 = iATR(NULL,0,总_74_in_AB0,子_7_in) * 总_73_do_AA8;
             }
             临_do_5 = 临_do_6;
           }
         }
         子_28_do = 临_do_5 ;
         ObjectCreate(0,子_27_st,OBJ_TEXT,0,木_2_da_ko[子_7_in],木_5_do_ko[子_7_in] - 子_28_do); 
         ObjectSetString(0,子_27_st,OBJPROP_TEXT,子_25_st); 
         ObjectSetInteger(0,子_27_st,OBJPROP_FONTSIZE,总_64_in_A74); 
         ObjectSetString(0,子_27_st,OBJPROP_FONT,总_68_st_A88); 
         ObjectSetInteger(0,子_27_st,OBJPROP_COLOR,总_66_ui_A7C); 
       }
     }
     else
     {
       if ( 子_23_do>=子_24_do && 子_21_do<子_22_do )
       {
         总_6_do_AC_ko[子_7_in] = 1.0;
         总_5_do_78_ko[子_7_in] = 0.0;
         if ( 子_7_in == 0 )
         {
           总_285_bo_1608 = true ;
           总_286_da_1610 = TimeCurrent() ;
           总_287_in_1618 = -1 ;
         }
         子_29_st="EMA2_DN_" + IntegerToString(木_2_da_ko[子_7_in],0,32);
         if ( ObjectFind(子_29_st) == -1 )
         {
           if ( !(总_69_bo_A94) )
           {
             临_do_7 = 总_71_in_A9C * Point;
           }
           else
           {
             if ( iATR(NULL,0,总_74_in_AB0,子_7_in)<=0.0 )
             {
               if ( 2 == 1 )
               {
                 临_do_7 = 总_70_in_A98 * Point;
               }
               else
               {
                 临_do_7 = 总_71_in_A9C * Point;
               }
             }
             else
             {
               临_do_8 = 0.0;
               if ( 2 == 1 )
               {
                 临_do_8 = iATR(NULL,0,总_74_in_AB0,子_7_in) * 总_72_do_AA0;
               }
               else
               {
                 临_do_8 = iATR(NULL,0,总_74_in_AB0,子_7_in) * 总_73_do_AA8;
               }
               临_do_7 = 临_do_8;
             }
           }
           子_30_do = 临_do_7 ;
           ObjectCreate(0,子_29_st,OBJ_TEXT,0,木_2_da_ko[子_7_in],木_4_do_ko[子_7_in] + 子_30_do); 
           ObjectSetString(0,子_29_st,OBJPROP_TEXT,子_26_st); 
           ObjectSetInteger(0,子_29_st,OBJPROP_FONTSIZE,总_64_in_A74); 
           ObjectSetString(0,子_29_st,OBJPROP_FONT,总_68_st_A88); 
           ObjectSetInteger(0,子_29_st,OBJPROP_COLOR,总_67_ui_A80); 
         }
       }
       else
       {
         if ( 木_1_in == 0 )
         {
           总_5_do_78_ko[子_7_in] = 0.0;
           总_6_do_AC_ko[子_7_in] = 0.0;
         }
       }
     }
     总_7_do_E0_ko[子_7_in] = INT_MAX;
     总_8_do_114_ko[子_7_in] = INT_MAX;
     总_9_do_148_ko[子_7_in] = INT_MAX;
     总_10_do_17C_ko[子_7_in] = INT_MAX;
     总_11_do_1B0_ko[子_7_in] = INT_MAX;
     总_12_do_1E4_ko[子_7_in] = INT_MAX;
     总_13_do_218_ko[子_7_in] = INT_MAX;
     总_14_do_24C_ko[子_7_in] = INT_MAX;
     总_15_do_280_ko[子_7_in] = INT_MAX;
     总_16_do_2B4_ko[子_7_in] = INT_MAX;
     总_17_do_2E8_ko[子_7_in] = INT_MAX;
     总_18_do_31C_ko[子_7_in] = INT_MAX;
     总_19_do_350_ko[子_7_in] = INT_MAX;
     总_20_do_384_ko[子_7_in] = INT_MAX;
     总_21_do_3B8_ko[子_7_in] = INT_MAX;
     总_22_do_3EC_ko[子_7_in] = INT_MAX;
     子_31_bo=子_9_do>子_10_do;
     子_32_bo=子_21_do>子_22_do;
     if ( 子_31_bo && 子_32_bo )
     {
       if ( 木_3_do_ko[子_7_in]>=木_6_do_ko[子_7_in] )
       {
         总_7_do_E0_ko[子_7_in] = 木_3_do_ko[子_7_in];
         总_8_do_114_ko[子_7_in] = 木_6_do_ko[子_7_in];
       }
       else
       {
         总_7_do_E0_ko[子_7_in] = 木_6_do_ko[子_7_in];
         总_8_do_114_ko[子_7_in] = 木_3_do_ko[子_7_in];
       }
       总_9_do_148_ko[子_7_in] = 木_4_do_ko[子_7_in];
       总_10_do_17C_ko[子_7_in] = 木_5_do_ko[子_7_in];
     }
     else
     {
       if ( 子_31_bo && !(子_32_bo) )
       {
         if ( 木_3_do_ko[子_7_in]>=木_6_do_ko[子_7_in] )
         {
           总_11_do_1B0_ko[子_7_in] = 木_3_do_ko[子_7_in];
           总_12_do_1E4_ko[子_7_in] = 木_6_do_ko[子_7_in];
         }
         else
         {
           总_11_do_1B0_ko[子_7_in] = 木_6_do_ko[子_7_in];
           总_12_do_1E4_ko[子_7_in] = 木_3_do_ko[子_7_in];
         }
         总_13_do_218_ko[子_7_in] = 木_4_do_ko[子_7_in];
         总_14_do_24C_ko[子_7_in] = 木_5_do_ko[子_7_in];
       }
       else
       {
         if ( !(子_31_bo) && !(子_32_bo) )
         {
           if ( 木_3_do_ko[子_7_in]>=木_6_do_ko[子_7_in] )
           {
             总_15_do_280_ko[子_7_in] = 木_3_do_ko[子_7_in];
             总_16_do_2B4_ko[子_7_in] = 木_6_do_ko[子_7_in];
           }
           else
           {
             总_15_do_280_ko[子_7_in] = 木_6_do_ko[子_7_in];
             总_16_do_2B4_ko[子_7_in] = 木_3_do_ko[子_7_in];
           }
           总_17_do_2E8_ko[子_7_in] = 木_4_do_ko[子_7_in];
           总_18_do_31C_ko[子_7_in] = 木_5_do_ko[子_7_in];
         }
         else
         {
           if ( !(子_31_bo) && 子_32_bo )
           {
             if ( 木_3_do_ko[子_7_in]>=木_6_do_ko[子_7_in] )
             {
               总_19_do_350_ko[子_7_in] = 木_3_do_ko[子_7_in];
               总_20_do_384_ko[子_7_in] = 木_6_do_ko[子_7_in];
             }
             else
             {
               总_19_do_350_ko[子_7_in] = 木_6_do_ko[子_7_in];
               总_20_do_384_ko[子_7_in] = 木_3_do_ko[子_7_in];
             }
             总_21_do_3B8_ko[子_7_in] = 木_4_do_ko[子_7_in];
             总_22_do_3EC_ko[子_7_in] = 木_5_do_ko[子_7_in];
           }
         }
       }
     }
     总_23_do_420_ko[子_7_in] = INT_MAX;
     总_24_do_454_ko[子_7_in] = INT_MAX;
     总_25_do_488_ko[子_7_in] = INT_MAX;
     总_26_do_4BC_ko[子_7_in] = INT_MAX;
     总_27_do_4F0_ko[子_7_in] = INT_MAX;
     总_28_do_524_ko[子_7_in] = INT_MAX;
     总_29_do_558_ko[子_7_in] = INT_MAX;
     总_30_do_58C_ko[子_7_in] = INT_MAX;
     总_31_do_5C0_ko[子_7_in] = INT_MAX;
     总_32_do_5F4_ko[子_7_in] = INT_MAX;
     总_33_do_628_ko[子_7_in] = INT_MAX;
     总_34_do_65C_ko[子_7_in] = INT_MAX;
     子_33_do = iATR(NULL,0,总_85_in_AF8,子_7_in) ;
     子_34_do = 0.0 ;
     子_35_in = 0 ;
    
     for (子_36_in = 0 ;总_85_in_AF8 >  0 && 子_7_in + 子_36_in < 木_0_in ; 子_36_in ++)
     {
       子_37_do = iATR(NULL,0,总_85_in_AF8,子_7_in + 子_36_in) ;
       if ( 子_37_do>0.0 )
       {
         子_34_do = 子_34_do + 子_37_do ;
         子_35_in ++;
       }
       if ( 子_36_in >= 总_85_in_AF8 )   break;
       
     }
   
     if ( 子_35_in >  0 )
     {
       子_34_do = 子_34_do / 子_35_in ;
     }
     else
     {
       if ( 子_33_do>0.0 )
       {
         子_34_do = 子_33_do ;
       }
       else
       {
         子_34_do = Point * 100.0 ;
       }
     }
     if ( 总_89_bo_B14 )
     {
       子_38_do = iMA(NULL,0,总_82_in_AEC,0,1,0,子_7_in) ;
       子_39_do = iMA(NULL,0,总_82_in_AEC,0,1,0,子_8_in) ;
       子_40_do = 子_38_do - 子_39_do ;
       子_41_do=MathAbs(木_6_do_ko[子_7_in] - 子_38_do);
       if ( 子_33_do>0.0 )
       {
         临_do_9 = (MathAbs(子_40_do)) / 子_33_do;
       }
       else
       {
         临_do_9 = 0.0;
       }
       子_42_do = 临_do_9 ;
       子_43_in = 0 ;
       if ( 子_42_do<0.1 )
       {
         子_43_in = 3 ;
       }
       else
       {
         if ( 子_42_do<0.18 )
         {
           子_43_in = 2 ;
         }
         else
         {
           if ( 子_42_do<0.3 )
           {
             子_43_in = 1 ;
           }
         }
       }
       if ( 子_34_do>0.0 )
       {
         临_do_10 = 子_33_do / 子_34_do;
       }
       else
       {
         临_do_10 = 1.0;
       }
       子_44_do = 临_do_10 ;
       子_45_in = 0 ;
       if ( 子_44_do<0.45 )
       {
         子_45_in = 3 ;
       }
       else
       {
         if ( 子_44_do<0.6 )
         {
           子_45_in = 2 ;
         }
         else
         {
           if ( 子_44_do<0.75 )
           {
             子_45_in = 1 ;
           }
         }
       }
       if ( 子_33_do>0.0 )
       {
         临_do_11 = 子_41_do / 子_33_do;
       }
       else
       {
         临_do_11 = 0.0;
       }
       子_46_do = 临_do_11 ;
       子_47_in = 0 ;
       if ( 子_46_do<0.25 )
       {
         子_47_in = 3 ;
       }
       else
       {
         if ( 子_46_do<0.4 )
         {
           子_47_in = 2 ;
         }
         else
         {
           if ( 子_46_do<0.6 )
           {
             子_47_in = 1 ;
           }
         }
       }
       子_48_bo=木_6_do_ko[子_7_in]>子_38_do;
       子_49_bo=子_40_do>0.0;
       子_50_bo = 子_48_bo==子_49_bo ;
       子_51_in = (子_50_bo) ?0:2  ;
       子_52_in = 0 ;
       if ( 子_7_in <  木_0_in - 3 )
       {
         子_53_bo=总_26_do_4BC_ko[子_7_in + 1]!=INT_MAX;
         子_54_bo=总_26_do_4BC_ko[子_7_in + 2]!=INT_MAX;
         if ( 子_53_bo )
         {
           子_52_in = 1 ;
         }
         if ( 子_54_bo )
         {
           子_52_in ++;
         }
       }
       子_55_in=子_43_in + 子_45_in + 子_47_in + 子_51_in;
       子_56_in = 5 ;
       if ( 子_52_in >= 2 )
       {
         子_56_in = 4 ;
       }
       子_57_bo=子_55_in>=子_56_in;
       子_58_do = 子_38_do ;
       if ( 子_57_bo )
       {
         总_26_do_4BC_ko[子_7_in] = 子_38_do;
       }
       else
       {
         if ( 木_6_do_ko[子_7_in]>子_38_do && 子_40_do>0.0 )
         {
           总_23_do_420_ko[子_7_in] = 子_58_do;
         }
         else
         {
           if ( 木_6_do_ko[子_7_in]<子_38_do && 子_40_do<0.0 )
           {
             总_24_do_454_ko[子_7_in] = 子_58_do;
           }
           else
           {
             总_25_do_488_ko[子_7_in] = 子_58_do;
           }
         }
       }
     }
     if ( 总_90_bo_B15 )
     {
       子_59_do = iMA(NULL,0,总_83_in_AF0,0,1,0,子_7_in) ;
       子_60_do = iMA(NULL,0,总_83_in_AF0,0,1,0,子_8_in) ;
       子_61_do = 子_59_do - 子_60_do ;
       子_62_do=MathAbs(木_6_do_ko[子_7_in] - 子_59_do);
       if ( 子_33_do>0.0 )
       {
         临_do_12 = (MathAbs(子_61_do)) / 子_33_do;
       }
       else
       {
         临_do_12 = 0.0;
       }
       子_63_do = 临_do_12 ;
       子_64_in = 0 ;
       if ( 子_63_do<0.1 )
       {
         子_64_in = 3 ;
       }
       else
       {
         if ( 子_63_do<0.18 )
         {
           子_64_in = 2 ;
         }
         else
         {
           if ( 子_63_do<0.3 )
           {
             子_64_in = 1 ;
           }
         }
       }
       if ( 子_34_do>0.0 )
       {
         临_do_13 = 子_33_do / 子_34_do;
       }
       else
       {
         临_do_13 = 1.0;
       }
       子_65_do = 临_do_13 ;
       子_66_in = 0 ;
       if ( 子_65_do<0.45 )
       {
         子_66_in = 3 ;
       }
       else
       {
         if ( 子_65_do<0.6 )
         {
           子_66_in = 2 ;
         }
         else
         {
           if ( 子_65_do<0.75 )
           {
             子_66_in = 1 ;
           }
         }
       }
       if ( 子_33_do>0.0 )
       {
         临_do_14 = 子_62_do / 子_33_do;
       }
       else
       {
         临_do_14 = 0.0;
       }
       子_67_do = 临_do_14 ;
       子_68_in = 0 ;
       if ( 子_67_do<0.25 )
       {
         子_68_in = 3 ;
       }
       else
       {
         if ( 子_67_do<0.4 )
         {
           子_68_in = 2 ;
         }
         else
         {
           if ( 子_67_do<0.6 )
           {
             子_68_in = 1 ;
           }
         }
       }
       子_69_bo=木_6_do_ko[子_7_in]>子_59_do;
       子_70_bo=子_61_do>0.0;
       子_71_in = (子_69_bo == 子_70_bo) ?0:2  ;
       子_72_in = 0 ;
       if ( 子_7_in <  木_0_in - 3 )
       {
         子_73_bo=总_30_do_58C_ko[子_7_in + 1]!=INT_MAX;
         子_74_bo=总_30_do_58C_ko[子_7_in + 2]!=INT_MAX;
         if ( 子_73_bo )
         {
           子_72_in = 1 ;
         }
         if ( 子_74_bo )
         {
           子_72_in ++;
         }
       }
       子_75_in=子_64_in + 子_66_in + 子_68_in + 子_71_in;
       子_76_in = 5 ;
       if ( 子_72_in >= 2 )
       {
         子_76_in = 4 ;
       }
       子_77_bo=子_75_in>=子_76_in;
       子_78_do = 子_59_do ;
       if ( 子_77_bo )
       {
         总_30_do_58C_ko[子_7_in] = 子_59_do;
       }
       else
       {
         if ( 木_6_do_ko[子_7_in]>子_59_do && 子_61_do>0.0 )
         {
           总_27_do_4F0_ko[子_7_in] = 子_78_do;
         }
         else
         {
           if ( 木_6_do_ko[子_7_in]<子_59_do && 子_61_do<0.0 )
           {
             总_28_do_524_ko[子_7_in] = 子_78_do;
           }
           else
           {
             总_29_do_558_ko[子_7_in] = 子_78_do;
           }
         }
       }
     }
     if ( 总_91_bo_B16 )
     {
       子_79_do = iMA(NULL,0,总_84_in_AF4,0,1,0,子_7_in) ;
       子_80_do = 子_79_do ;
       if ( 木_6_do_ko[子_7_in]>子_33_do * 总_87_do_B08 + 子_80_do )
       {
         总_31_do_5C0_ko[子_7_in] = 子_80_do;
         总_33_do_628_ko[子_7_in] = 子_80_do;
         总_34_do_65C_ko[子_7_in] = INT_MAX;
       }
       else
       {
         if ( 木_6_do_ko[子_7_in]<子_79_do - 子_33_do * 总_87_do_B08 )
         {
           总_32_do_5F4_ko[子_7_in] = 子_80_do;
           总_34_do_65C_ko[子_7_in] = 子_80_do;
           总_33_do_628_ko[子_7_in] = INT_MAX;
         }
         else
         {
           if ( 子_8_in <  木_0_in )
           {
             子_81_bo = 总_31_do_5C0_ko[子_8_in]!=INT_MAX || 总_33_do_628_ko[子_8_in]!=INT_MAX ;
             子_82_bo = 总_32_do_5F4_ko[子_8_in]!=INT_MAX || 总_34_do_65C_ko[子_8_in]!=INT_MAX ;
             if ( 子_81_bo )
             {
               总_33_do_628_ko[子_7_in] = 子_80_do;
               总_34_do_65C_ko[子_7_in] = INT_MAX;
             }
             else
             {
               if ( 子_82_bo )
               {
                 总_34_do_65C_ko[子_7_in] = 子_80_do;
                 总_33_do_628_ko[子_7_in] = INT_MAX;
               }
             }
           }
         }
       }
     }
     if ( 总_93_bo_B24 )
     {
       总_35_do_690_ko[子_7_in] = INT_MAX;
       总_36_do_6C4_ko[子_7_in] = INT_MAX;
       总_37_do_6F8_ko[子_7_in] = INT_MAX;
       总_38_do_72C_ko[子_7_in] = INT_MAX;
       总_39_do_760_ko[子_7_in] = INT_MAX;
       总_40_do_794_ko[子_7_in] = INT_MAX;
       子_83_bo=总_26_do_4BC_ko[子_7_in]!=INT_MAX;
       子_84_bo=子_33_do<子_34_do * 0.6;
       if ( !(子_83_bo) && !(子_84_bo) )
       {
         子_85_do=MathAbs(木_6_do_ko[子_7_in] - 木_3_do_ko[子_7_in]);
         if ( 子_8_in <  木_0_in )
         {
           子_86_bo=总_23_do_420_ko[子_8_in]!=INT_MAX;
           子_87_bo=总_24_do_454_ko[子_8_in]!=INT_MAX;
           子_88_bo=总_25_do_488_ko[子_8_in]!=INT_MAX;
           子_89_bo=总_26_do_4BC_ko[子_8_in]!=INT_MAX;
           子_90_bo=总_23_do_420_ko[子_7_in]!=INT_MAX;
           子_91_bo=总_24_do_454_ko[子_7_in]!=INT_MAX;
           子_92_bo=总_25_do_488_ko[子_7_in]!=INT_MAX;
           子_93_bo=总_26_do_4BC_ko[子_7_in]!=INT_MAX;
           子_94_bo=总_27_do_4F0_ko[子_8_in]!=INT_MAX;
           子_95_bo=总_28_do_524_ko[子_8_in]!=INT_MAX;
           子_96_bo=总_29_do_558_ko[子_8_in]!=INT_MAX;
           子_97_bo=总_30_do_58C_ko[子_8_in]!=INT_MAX;
           子_98_bo=总_27_do_4F0_ko[子_7_in]!=INT_MAX;
           子_99_bo=总_28_do_524_ko[子_7_in]!=INT_MAX;
           子_100_bo=总_29_do_558_ko[子_7_in]!=INT_MAX;
           子_101_bo=总_30_do_58C_ko[子_7_in]!=INT_MAX;
           子_102_in = -1 ;
          
           for (子_103_in=子_7_in + 1 ;子_103_in <  子_7_in + 总_98_in_B40 && 子_103_in < 木_0_in ; 子_103_in ++)
           {
             if ( ( 总_35_do_690_ko[子_103_in]!=INT_MAX || 总_36_do_6C4_ko[子_103_in]!=INT_MAX || 总_37_do_6F8_ko[子_103_in]!=INT_MAX || 总_38_do_72C_ko[子_103_in]!=INT_MAX || 总_39_do_760_ko[子_103_in]!=INT_MAX || 总_40_do_794_ko[子_103_in]!=INT_MAX ) )
             {
               子_102_in = 子_103_in ;
               break;
             }
             if ( 子_103_in >= 子_7_in + 总_98_in_B40 )   break;
             
           }
          
           子_104_bo = 子_102_in==-1 ;
           if ( 子_104_bo )
           {
             子_105_do = 0.0 ;
             if ( 总_75_bo_AB4 )
             {
               子_105_do = 子_33_do * 总_76_do_AB8 ;
             }
             else
             {
               子_105_do = 总_100_in_B48 * Point ;
             }
             子_106_do = 子_105_do ;
             子_107_do = 子_105_do * 1.8 ;
             子_108_do = 子_105_do * 2.8 ;
             子_109_bo =  (子_87_bo || 子_89_bo)  &&  (子_92_bo || 子_90_bo) ;
             if ( 子_109_bo && 子_85_do>=子_33_do * 总_95_do_B28 && 木_6_do_ko[子_7_in]>木_3_do_ko[子_7_in] )
             {
               总_35_do_690_ko[子_7_in] = 木_5_do_ko[子_7_in] - 子_106_do;
             }
             if ( !(子_94_bo) && 子_98_bo && 子_85_do>=子_33_do * 总_96_do_B30 && 木_6_do_ko[子_7_in]>木_3_do_ko[子_7_in] )
             {
               子_110_bo = true ;
               if ( 总_94_bo_B25 )
               {
                 子_111_bo = false ;
              
                 for (子_112_in=子_7_in + 1 ;子_112_in <  子_7_in + 总_99_in_B44 && 子_112_in < 木_0_in ; 子_112_in ++)
                 {
                   if ( 总_35_do_690_ko[子_112_in]!=INT_MAX )
                   {
                     子_111_bo = true ;
                     break;
                   }
                   if ( 子_112_in >= 子_7_in + 总_99_in_B44 )   break;
                   
                 }
             
                 子_110_bo = 子_111_bo ;
               }
               if ( 子_110_bo )
               {
                 总_36_do_6C4_ko[子_7_in] = 木_5_do_ko[子_7_in] - 子_107_do;
               }
             }
             if ( !(子_86_bo) && 子_90_bo && 子_85_do>=子_33_do * 总_97_do_B38 && 木_6_do_ko[子_7_in]>木_3_do_ko[子_7_in] )
             {
               子_113_bo = true ;
               if ( 总_94_bo_B25 )
               {
                 子_114_bo = false ;
                
                 for (子_115_in=子_7_in + 1 ;子_115_in <  子_7_in + 总_99_in_B44 && 子_115_in < 木_0_in ; 子_115_in ++)
                 {
                   if ( 总_36_do_6C4_ko[子_115_in]!=INT_MAX )
                   {
                     子_114_bo = true ;
                     break;
                   }
                   if ( 子_115_in >= 子_7_in + 总_99_in_B44 )   break;
                   
                 }
                
                 子_113_bo = 子_114_bo ;
               }
               if ( 子_113_bo )
               {
                 总_37_do_6F8_ko[子_7_in] = 木_5_do_ko[子_7_in] - 子_108_do;
               }
             }
             子_116_bo =  (子_86_bo || 子_89_bo)  &&  (子_92_bo || 子_91_bo) ;
             if ( 子_116_bo && 子_85_do>=子_33_do * 总_95_do_B28 && 木_6_do_ko[子_7_in]<木_3_do_ko[子_7_in] )
             {
               总_38_do_72C_ko[子_7_in] = 木_4_do_ko[子_7_in] + 子_106_do;
             }
             if ( !(子_95_bo) && 子_99_bo && 子_85_do>=子_33_do * 总_96_do_B30 && 木_6_do_ko[子_7_in]<木_3_do_ko[子_7_in] )
             {
               子_117_bo = true ;
               if ( 总_94_bo_B25 )
               {
                 子_118_bo = false ;
                 
                 for (子_119_in=子_7_in + 1 ;子_119_in <  子_7_in + 总_99_in_B44 && 子_119_in < 木_0_in ; 子_119_in ++)
                 {
                   if ( 总_38_do_72C_ko[子_119_in]!=INT_MAX )
                   {
                     子_118_bo = true ;
                     break;
                   }
                   if ( 子_119_in >= 子_7_in + 总_99_in_B44 )   break;
                   
                 }
                 
                 子_117_bo = 子_118_bo ;
               }
               if ( 子_117_bo )
               {
                 总_39_do_760_ko[子_7_in] = 木_4_do_ko[子_7_in] + 子_107_do;
               }
             }
             if ( !(子_87_bo) && 子_91_bo && 子_85_do>=子_33_do * 总_97_do_B38 && 木_6_do_ko[子_7_in]<木_3_do_ko[子_7_in] )
             {
               子_120_bo = true ;
               if ( 总_94_bo_B25 )
               {
                 子_121_bo = false ;
                
                 for (子_122_in=子_7_in + 1 ;子_122_in <  子_7_in + 总_99_in_B44 && 子_122_in < 木_0_in ; 子_122_in ++)
                 {
                   if ( 总_39_do_760_ko[子_122_in]!=INT_MAX )
                   {
                     子_121_bo = true ;
                     break;
                   }
                   if ( 子_122_in >= 子_7_in + 总_99_in_B44 )   break;
                   
                 }
               
                 子_120_bo = 子_121_bo ;
               }
               if ( 子_120_bo )
               {
                 总_40_do_794_ko[子_7_in] = 木_4_do_ko[子_7_in] + 子_108_do;
               }
             }
             子_123_bo = false ;
             子_124_do = 0.0 ;
             子_125_do = 0.0 ;
             子_126_ui = White ;
             if ( 总_37_do_6F8_ko[子_7_in]!=INT_MAX )
             {
               子_123_bo = true ;
               子_124_do = 木_5_do_ko[子_7_in] ;
               子_125_do = 子_108_do * 1.5 ;
               子_126_ui = Red ;
             }
             else
             {
               if ( 总_36_do_6C4_ko[子_7_in]!=INT_MAX )
               {
                 子_123_bo = true ;
                 子_124_do = 木_5_do_ko[子_7_in] ;
                 子_125_do = 子_107_do * 1.5 ;
                 子_126_ui = LightPink ;
               }
               else
               {
                 if ( 总_35_do_690_ko[子_7_in]!=INT_MAX )
                 {
                   子_123_bo = true ;
                   子_124_do = 木_5_do_ko[子_7_in] ;
                   子_125_do = 子_106_do * 1.5 ;
                   子_126_ui = LightPink ;
                 }
               }
             }
             if ( 子_123_bo )
             {
               子_127_st="Arrow_Buy_" + IntegerToString(木_2_da_ko[子_7_in],0,32);
               if ( ObjectFind(子_127_st) == -1 )
               {
                 ObjectCreate(0,子_127_st,OBJ_TEXT,0,木_2_da_ko[子_7_in],子_124_do - 子_125_do); 
                 ObjectSetString(0,子_127_st,OBJPROP_TEXT,"做多"); 
                 ObjectSetInteger(0,子_127_st,OBJPROP_FONTSIZE,0x8); 
                 ObjectSetString(0,子_127_st,OBJPROP_FONT,总_68_st_A88); 
                 ObjectSetInteger(0,子_127_st,OBJPROP_COLOR,子_126_ui); 
                 ObjectSetInteger(0,子_127_st,OBJPROP_ANCHOR,0x7); 
               }
             }
             子_128_bo = false ;
             子_129_do = 0.0 ;
             子_130_do = 0.0 ;
             子_131_ui = White ;
             if ( 总_40_do_794_ko[子_7_in]!=INT_MAX )
             {
               子_128_bo = true ;
               子_129_do = 木_4_do_ko[子_7_in] ;
               子_130_do = 子_108_do * 1.5 ;
               子_131_ui = Aqua ;
             }
             else
             {
               if ( 总_39_do_760_ko[子_7_in]!=INT_MAX )
               {
                 子_128_bo = true ;
                 子_129_do = 木_4_do_ko[子_7_in] ;
                 子_130_do = 子_107_do * 1.5 ;
                 子_131_ui = LightBlue ;
               }
               else
               {
                 if ( 总_38_do_72C_ko[子_7_in]!=INT_MAX )
                 {
                   子_128_bo = true ;
                   子_129_do = 木_4_do_ko[子_7_in] ;
                   子_130_do = 子_106_do * 1.5 ;
                   子_131_ui = LightBlue ;
                 }
               }
             }
             if ( 子_128_bo )
             {
               子_132_st="Arrow_Sell_" + IntegerToString(木_2_da_ko[子_7_in],0,32);
               if ( ObjectFind(子_132_st) == -1 )
               {
                 ObjectCreate(0,子_132_st,OBJ_TEXT,0,木_2_da_ko[子_7_in],子_129_do + 子_130_do); 
                 ObjectSetString(0,子_132_st,OBJPROP_TEXT,"做空"); 
                 ObjectSetInteger(0,子_132_st,OBJPROP_FONTSIZE,0x8); 
                 ObjectSetString(0,子_132_st,OBJPROP_FONT,总_68_st_A88); 
                 ObjectSetInteger(0,子_132_st,OBJPROP_COLOR,子_131_ui); 
                 ObjectSetInteger(0,子_132_st,OBJPROP_ANCHOR,0x3); 
               }
             }
           }
         }
       }
     }
     
     总_41_do_7C8_ko[子_7_in] = lizong_40(子_7_in);
     
     子_133_do=MathAbs(木_6_do_ko[子_7_in] - 木_3_do_ko[子_7_in]);
     子_134_do = 木_4_do_ko[子_7_in] - 木_5_do_ko[子_7_in] ;
     临_do_15 = 子_33_do;
     临_do_16 = 子_134_do;
     临_do_17 = 子_133_do;
     
     if ( ( 临_do_17<0.0 || 临_do_16<0.0 || 临_do_15<0.0 ) )
     {
       临_in_18 = 50;
     }
     else
     {
       
       if ( 临_do_15<=0.000001 )
       {
         临_do_15 = (临_do_16>0.0) ?临_do_16:0.000001 ;
       }
       if ( 临_do_15<=0.000001 )
       {
         临_in_18 = 50;
       }
       else
       {
        
         临_in_19 = 50;
         临_in_19=临_in_19 + int((临_do_17 / (临_do_15) * 30.0 >= 30) ?30.0:临_do_17 / (临_do_15) * 30.0 );
         if ( 临_do_16>0.000001 )
         {
           临_in_19=临_in_19 + int(临_do_17 / 临_do_16 * 20.0);
         }
         if ( 临_do_15>0.000001 )
         {
           临_do_20 = 临_do_16 / (临_do_15);
           if ( 临_do_20>0.5 && 临_do_20<1.5 )
           {
             临_in_19=临_in_19 + 10;
           }
           else
           {
             if ( 临_do_20>2.0 )
             {
               临_in_19=临_in_19 - 10;
             }
           }
         }
         临_in_21 = 临_in_19;
         if ( 临_in_19 <= 0 )
         {
           临_in_22 = 0;
         }
         else
         {
           临_in_22 = 临_in_21;
         }
         临_in_18 = MathMin(临_in_22,100);
       }
     }
     总_42_do_7FC_ko[子_7_in] = 临_in_18;
     总_43_do_830_ko[子_7_in] = lizong_41(子_7_in);
     if ( ( 子_34_do<=0.000001 || 子_33_do<=0.0 ) )
     {
       临_in_23 = 50;
     }
     else
     {
       临_do_24 = 子_33_do / 子_34_do;
       临_in_25 = 50;
       if ( 临_do_24>1.5 )
       {
         临_in_25 = int(((临_do_24 - 1.5) * 40.0 >= 20) ?20.0:(临_do_24 - 1.5) * 40.0 ) + 80;
       }
       else
       {
         if ( 临_do_24>1.0 )
         {
           临_in_25 = int((临_do_24 - 1.0) * 60.0) + 50;
         }
         else
         {
           if ( 临_do_24>0.6 )
           {
             临_in_25 = int((临_do_24 - 0.6) * 50.0) + 30;
           }
           else
           {
             临_in_25 = int(临_do_24 * 50.0);
           }
         }
       }
       临_in_26 = 临_in_25;
       if ( 临_in_25 <= 0 )
       {
         临_in_27 = 0;
       }
       else
       {
         临_in_27 = 临_in_26;
       }
       临_in_23 = MathMin(临_in_27,100);
     }
     总_44_do_864_ko[子_7_in] = 临_in_23;
     临_in_30 = 1;
     临_lo_28 = iTime(NULL,PERIOD_D1,1);
     if ( 临_lo_28 == 0 )
     {
       临_do_29 = 0.0;
     }
     else
     {
       if ( TimeDayOfWeek(临_lo_28) == 0 )
       {
         临_in_30 = 2;
       }
       if ( ( iHigh(NULL,PERIOD_D1,临_in_30)<=0.0 || iLow(NULL,PERIOD_D1,临_in_30)<=0.0 || iClose(NULL,PERIOD_D1,临_in_30)<=0.0 || iHigh(NULL,PERIOD_D1,临_in_30)<iLow(NULL,PERIOD_D1,临_in_30) ) )
       {
         临_do_29 = 0.0;
       }
       else
       {
         临_do_29 = (iHigh(NULL,PERIOD_D1,临_in_30) + iLow(NULL,PERIOD_D1,临_in_30) + iClose(NULL,PERIOD_D1,临_in_30)) / 3.0;
       }
     }
     总_45_do_898_ko[子_7_in] = 临_do_29;
     总_46_do_8CC_ko[子_7_in] = 0.0;
     总_47_do_900_ko[子_7_in] = 0.0;
     总_48_do_934_ko[子_7_in] = 0.0;
     if ( 总_182_bo_CF4 && 总_263_in_1224 >= 0 && 总_263_in_1224 <  7 )
     {
       临_in_31 = 总_257_in_10D8_si7[总_263_in_1224];
       总_46_do_8CC_ko[子_7_in] = 总_254_do_F94_si7[总_263_in_1224];
       if ( Point>0.0 )
       {
         临_do_32 = (iClose(NULL,0,子_7_in) - 总_254_do_F94_si7[总_263_in_1224]) / Point;
       }
       else
       {
         临_do_32 = 0.0;
       }
       总_47_do_900_ko[子_7_in] = 临_do_32;
       总_48_do_934_ko[子_7_in] = MathMin(临_in_31 * 5,100);
     }
     总_49_do_968_ko[子_7_in] = lizong_42(子_7_in);
     临_bo_33 = 总_32_do_5F4_ko[子_7_in]!=INT_MAX;
     临_in_34 = 0;
     if ( 总_23_do_420_ko[子_7_in]!=INT_MAX && 总_27_do_4F0_ko[子_7_in]!=INT_MAX && 总_31_do_5C0_ko[子_7_in]!=INT_MAX )
     {
       临_in_34 = 3;
     }
     else
     {
       if ( 总_23_do_420_ko[子_7_in]!=INT_MAX && 总_27_do_4F0_ko[子_7_in]!=INT_MAX )
       {
         临_in_34 = 2;
       }
       else
       {
         if ( ( 总_23_do_420_ko[子_7_in]!=INT_MAX || (总_25_do_488_ko[子_7_in]!=INT_MAX && 总_27_do_4F0_ko[子_7_in]!=INT_MAX) ) )
         {
           临_in_34 = 1;
         }
         else
         {
           if ( 总_24_do_454_ko[子_7_in]!=INT_MAX && 总_28_do_524_ko[子_7_in]!=INT_MAX && 临_bo_33 )
           {
             临_in_34 = -3;
           }
           else
           {
             if ( 总_24_do_454_ko[子_7_in]!=INT_MAX && 总_28_do_524_ko[子_7_in]!=INT_MAX )
             {
               临_in_34 = -2;
             }
             else
             {
               if ( ( 总_24_do_454_ko[子_7_in]!=INT_MAX || (总_25_do_488_ko[子_7_in]!=INT_MAX && 总_28_do_524_ko[子_7_in]!=INT_MAX) ) )
               {
                 临_in_34 = -1;
               }
               else
               {
                 临_in_34 = 0;
               }
             }
           }
         }
       }
     }
     总_50_do_99C_ko[子_7_in] = 临_in_34;
     子_135_do = (子_9_do + 子_10_do + 子_21_do + 子_22_do) / 4.0 ;
     if ( Point>0.0 )
     {
       临_do_35 = (木_6_do_ko[子_7_in] - 子_135_do) / Point;
     }
     else
     {
       临_do_35 = 0.0;
     }
     总_51_do_9D0_ko[子_7_in] = 临_do_35;
     临_in_36 = MathAbs(int(总_41_do_7C8_ko[子_7_in]));
     if ( 子_34_do>0.0 )
     {
       临_do_37 = 子_33_do / 子_34_do;
     }
     else
     {
       临_do_37 = 1.0;
     }
     临_do_38 = 临_do_37;
     临_in_39 = 1;
     if ( 临_in_36 >= 70 && 临_do_37>1.2 )
     {
       临_in_39 = 3;
     }
     else
     {
       if ( 临_in_36 >= 70 && 临_do_38<0.8 )
       {
         临_in_39 = 4;
       }
       else
       {
         if ( 临_in_36 >= 40 )
         {
           临_in_39 = 2;
         }
         else
         {
           临_in_39 = 1;
         }
       }
     }
     总_52_do_A04_ko[子_7_in] = 临_in_39;
   }
 }
 if ( ShowCountdown )
 {
  
   子_136_da = iTime(NULL,0,0) ;
   
   子_137_in = PeriodSeconds(0) ;
   
   子_138_lo=子_136_da + 子_137_in;
   子_139_da = TimeCurrent() ;
   子_140_in = (int)(子_138_lo - 子_139_da);
   if ( 子_140_in <  0 )
   {
     子_140_in = 0 ;
   }
   子_141_st = "" ;
   子_142_ui = 总_103_ui_B54 ;
   子_143_in = 总_102_in_B50 ;
   if ( 总_101_bo_B4C )
   {
     if ( 子_137_in >  0 )
     {
       临_do_40 = 子_140_in / 子_137_in * 100.0;
     }
     else
     {
       临_do_40 = 0.0;
     }
     子_144_do = 临_do_40 ;
     子_145_in = Period() ;
     if ( Period() <= 5 )
     {
       子_146_in=子_140_in / 60;
       子_147_in=子_140_in % 60;
       子_141_st = StringFormat("%02d:%02d",子_146_in,子_147_in) ;
       子_143_in = 9 ;
     }
     else
     {
       if ( 子_145_in <= 30 )
       {
         子_148_in=子_140_in / 60;
         子_149_in=子_140_in % 60;
         子_141_st = StringFormat("%02d:%02d",子_148_in,子_149_in) ;
         子_143_in = 10 ;
       }
       else
       {
         if ( 子_145_in <= 240 )
         {
           子_150_in=子_140_in / 3600;
           子_151_in=子_140_in % 3600 / 60;
           子_152_in=子_140_in % 60;
           if ( 子_150_in >  0 )
           {
             子_141_st = StringFormat("%d:%02d:%02d",子_150_in,子_151_in,子_152_in) ;
           }
           else
           {
             子_141_st = StringFormat("%02d:%02d",子_151_in,子_152_in) ;
           }
           子_143_in = 11 ;
         }
         else
         {
           if ( 子_145_in == 1440 )
           {
             子_153_in=子_140_in / 3600;
             子_154_in=子_140_in % 3600 / 60;
             if ( 子_153_in >  0 )
             {
               子_141_st = StringFormat("%d时%02d分",子_153_in,子_154_in) ;
             }
             else
             {
               子_141_st = StringFormat("%d分",子_154_in) ;
             }
             子_143_in = 12 ;
           }
           else
           {
             if ( 子_145_in == 10080 )
             {
               子_155_in=子_140_in / 86400;
               子_156_in=子_140_in % 86400 / 3600;
               if ( 子_155_in >  0 )
               {
                 子_141_st = StringFormat("%d天%d时",子_155_in,子_156_in) ;
               }
               else
               {
                 子_141_st = StringFormat("%d时",子_156_in) ;
               }
               子_143_in = 13 ;
             }
             else
             {
               子_157_in=子_140_in / 86400;
               子_158_in=子_140_in % 86400 / 3600;
               if ( 子_157_in >  0 && 子_158_in >  0 )
               {
                 子_141_st = StringFormat("%d天%d时",子_157_in,子_158_in) ;
               }
               else
               {
                 if ( 子_157_in >  0 )
                 {
                   子_141_st = StringFormat("%d天",子_157_in) ;
                 }
                 else
                 {
                   子_141_st = StringFormat("%d时",子_158_in) ;
                 }
               }
               子_143_in = 14 ;
             }
           }
         }
       }
     }
     if ( 总_105_bo_B60 )
     {
       if ( 子_144_do>50.0 )
       {
         子_142_ui = LimeGreen ;
       }
       else
       {
         if ( 子_144_do>20.0 )
         {
           子_142_ui = Yellow ;
         }
         else
         {
           子_142_ui = Red ;
         }
       }
     }
   }
   else
   {
     子_159_in=子_140_in / 60;
     子_160_in=子_140_in % 60;
     子_141_st = StringFormat("%02d:%02d",子_159_in,子_160_in) ;
   }
   子_161_do = iHigh(NULL,0,0) ;
   子_162_do = iLow(NULL,0,0) ;
   子_163_do = 子_161_do - 子_162_do ;
   子_164_do = 0.0 ;
   if ( 总_106_bo_B61 )
   {
     子_165_do = Ask ;
     子_166_do = iATR(Symbol(),0,总_74_in_AB0,0) ;
     if ( 子_166_do<=0.0 )
     {
       子_166_do = Point * 100.0 ;
     }
     子_164_do = 子_165_do - 子_166_do * 总_107_do_B68 ;
   }
   else
   {
     子_164_do = 子_163_do * 0.5 + 子_162_do ;
   }
   子_167_da=子_136_da + int(子_137_in * 总_104_do_B58);
   子_168_st = "Countdown_Current" ;
   if ( ObjectFind(子_168_st) == -1 )
   {
     ObjectCreate(0,子_168_st,OBJ_TEXT,0,子_167_da,子_164_do); 
     ObjectSetString(0,子_168_st,OBJPROP_FONT,总_68_st_A88); 
     ObjectSetInteger(0,子_168_st,OBJPROP_ANCHOR,0x1); 
   }
   ObjectSetString(0,子_168_st,OBJPROP_TEXT," " + 子_141_st); 
   ObjectSetInteger(0,子_168_st,OBJPROP_FONTSIZE,子_143_in); 
   ObjectSetInteger(0,子_168_st,OBJPROP_COLOR,子_142_ui); 
   ObjectMove(0,子_168_st,0,子_167_da,子_164_do); 
 }
 else
 {
   子_169_st = "Countdown_Current" ;
   if ( ObjectFind(子_169_st) != -1 )
   {
     ObjectDelete(子_169_st); 
   }
 }
 if ( ShowPivot )
 {
   
   子_170_in = 1 ;
   子_171_da = iTime(NULL,PERIOD_D1,1) ;
   
   子_172_bo = true ;
   
   子_173_do = 0.0 ;
   子_174_do = 0.0 ;
   子_175_do = 0.0 ;
   if ( 子_171_da == 0 )
   {
     Print("警告: 无法获取日线数据，跳过多空分水岭绘制"); 
     子_172_bo = false ;
   }
   if ( 子_172_bo )
   {
     子_176_in = TimeDayOfWeek(子_171_da) ;
     if ( 子_176_in == 0 )
     {
       子_170_in = 2 ;
     }
     子_173_do = iHigh(NULL,PERIOD_D1,子_170_in) ;
     子_174_do = iLow(NULL,PERIOD_D1,子_170_in) ;
     子_175_do = iClose(NULL,PERIOD_D1,子_170_in) ;
     if ( ( 子_173_do<=0.0 || 子_174_do<=0.0 || 子_175_do<=0.0 || 子_173_do<子_174_do ) )
     {
       Print("警告: 日线数据无效，跳过多空分水岭绘制"); 
       子_172_bo = false ;
     }
   }
   if ( 子_172_bo )
   {
     子_177_do = (子_173_do + 子_174_do + 子_175_do) / 3.0 ;
     子_178_do = 子_177_do * 2.0 - 子_174_do ;
     子_179_do = 子_177_do * 2.0 - 子_173_do ;
     子_180_do = 子_173_do - 子_174_do + 子_177_do ;
     子_181_do = 子_177_do - (子_173_do - 子_174_do) ;
     子_182_do = 子_173_do - 子_174_do * 2.0 + 子_177_do * 2.0 ;
     子_183_do = 子_177_do * 2.0 - (子_173_do * 2.0 - 子_174_do) ;
     lizong_8("Pivot_Main",子_177_do,总_108_ui_B70,总_109_in_B74,0,"多空分水岭 " + DoubleToString(子_177_do,Digits)); 
     lizong_8("Pivot_Buy_1",子_178_do,Red,总_112_in_B80,总_113_in_B84,"Buy 第㈠止盈位 " + DoubleToString(子_178_do,Digits)); 
     lizong_8("Pivot_Buy_2",子_180_do,OrangeRed,总_112_in_B80,总_113_in_B84,"Buy 第㈡止盈位 " + DoubleToString(子_180_do,Digits)); 
     lizong_8("Pivot_Buy_3",子_182_do,Crimson,总_112_in_B80,总_113_in_B84,"Buy 第㈢止盈位 " + DoubleToString(子_182_do,Digits)); 
     子_184_do = (子_173_do - 子_174_do) / Point ;
     子_185_do = 子_184_do * 0.382 ;
     lizong_8("Pivot_Buy_4",子_185_do * Point + 子_182_do,DeepPink,总_112_in_B80,总_113_in_B84,"Buy 第㈣止盈位 " + DoubleToString(子_185_do * Point + 子_182_do,Digits)); 
     lizong_8("Pivot_Buy_5",子_185_do * 2.0 * Point + 子_182_do,HotPink,总_112_in_B80,总_113_in_B84,"Buy 第㈤止盈位 " + DoubleToString(子_185_do * 2.0 * Point + 子_182_do,Digits)); 
     lizong_8("Pivot_Buy_6",子_185_do * 3.0 * Point + 子_182_do,LightPink,总_112_in_B80,总_113_in_B84,"Buy 第㈥止盈位 " + DoubleToString(子_185_do * 3.0 * Point + 子_182_do,Digits)); 
     lizong_8("Pivot_Buy_7",子_185_do * 4.0 * Point + 子_182_do,Pink,总_112_in_B80,总_113_in_B84,"Buy 第㈦止盈位 " + DoubleToString(子_185_do * 4.0 * Point + 子_182_do,Digits)); 
     lizong_8("Pivot_Sell_1",子_179_do,Lime,总_112_in_B80,总_113_in_B84,"Sell 第㈠止盈位 " + DoubleToString(子_179_do,Digits)); 
     lizong_8("Pivot_Sell_2",子_181_do,SpringGreen,总_112_in_B80,总_113_in_B84,"Sell 第㈡止盈位 " + DoubleToString(子_181_do,Digits)); 
     lizong_8("Pivot_Sell_3",子_183_do,Aqua,总_112_in_B80,总_113_in_B84,"Sell 第㈢止盈位 " + DoubleToString(子_183_do,Digits)); 
     lizong_8("Pivot_Sell_4",子_183_do - 子_185_do * Point,Aqua,总_112_in_B80,总_113_in_B84,"Sell 第㈣止盈位 " + DoubleToString(子_183_do - 子_185_do * Point,Digits)); 
     lizong_8("Pivot_Sell_5",子_183_do - 子_185_do * 2.0 * Point,Turquoise,总_112_in_B80,总_113_in_B84,"Sell 第㈤止盈位 " + DoubleToString(子_183_do - 子_185_do * 2.0 * Point,Digits)); 
     lizong_8("Pivot_Sell_6",子_183_do - 子_185_do * 3.0 * Point,MediumTurquoise,总_112_in_B80,总_113_in_B84,"Sell 第㈥止盈位 " + DoubleToString(子_183_do - 子_185_do * 3.0 * Point,Digits)); 
     lizong_8("Pivot_Sell_7",子_183_do - 子_185_do * 4.0 * Point,PaleTurquoise,总_112_in_B80,总_113_in_B84,"Sell 第㈦止盈位 " + DoubleToString(子_183_do - 子_185_do * 4.0 * Point,Digits)); 
   }
 }
 else
 {
   for (子_186_in=ObjectsTotal(-1) - 1 ; 子_186_in >= 0 ; 子_186_in --)
   {
     子_187_st = ObjectName(子_186_in) ;
     if ( StringFind(子_187_st,"Pivot_",0) == 0 )
     {
       ObjectDelete(子_187_st); 
     }
   }
 }
 if ( 总_233_bo_E00 )
 {
   lizong_33(); 
   子_188_in = iBars(NULL,总_234_in_E04) ;
   if ( 子_188_in <= 0 )
   {
     Print("警告: 无法获取目标时间框架(",总_234_in_E04,")的K线数据"); 
     return(木_0_in); 
   }
   if ( 总_120_in_BA0 <= 0 )
   {
     临_in_41 = 子_188_in;
   }
   else
   {
     临_in_41 = MathMin(总_120_in_BA0,子_188_in);
   }
   子_189_in = 临_in_41 ;
   for (子_190_in = 0 ; 子_190_in < 子_189_in ; 子_190_in ++)
   {
     子_191_da = iTime(NULL,总_234_in_E04,子_190_in) ;
     if ( 子_191_da == 0 )   continue;
     子_192_do = iOpen(NULL,总_234_in_E04,子_190_in) ;
     子_193_do = iClose(NULL,总_234_in_E04,子_190_in) ;
     子_194_do = iHigh(NULL,总_234_in_E04,子_190_in) ;
     子_195_do = iLow(NULL,总_234_in_E04,子_190_in) ;
     if ( 子_194_do<=0.0 || 子_195_do<=0.0 || 子_194_do<子_195_do )   continue;
     子_196_bo=子_193_do>子_192_do;
     子_197_do = 0.0 ;
     if ( Point>0.0 )
     {
       子_197_do = (子_194_do - 子_195_do) / Point ;
     }
     if ( 子_197_do<0.0 )
     {
       子_197_do = 0.0 ;
     }
     if ( 子_191_da != 0 && !(子_192_do<=0.0) && !(子_193_do<=0.0) )
     {
       临_st_42 = "CandlePoints_BODY_" + TimeToString(子_191_da,3);
       临_lo_43 = 子_191_da + 总_234_in_E04 * 60;
       临_ui_44 = (子_196_bo) ?总_117_ui_B94:总_118_ui_B98 ;
       if ( ObjectFind(临_st_42) == -1 )
       {
         ObjectCreate(0,临_st_42,OBJ_RECTANGLE,0,子_191_da,子_192_do,临_lo_43,子_193_do); 
         ObjectSetInteger(0,临_st_42,OBJPROP_COLOR,临_ui_44); 
         ObjectSetInteger(0,临_st_42,OBJPROP_BACK,0x1); 
         ObjectSetInteger(0,临_st_42,OBJPROP_FILL,总_119_bo_B9C); 
         ObjectSetInteger(0,临_st_42,OBJPROP_WIDTH,0x1); 
         ObjectSetInteger(0,临_st_42,OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,临_st_42,OBJPROP_SELECTED,0); 
       }
       else
       {
         ObjectMove(0,临_st_42,0,子_191_da,子_192_do); 
         ObjectMove(0,临_st_42,1,临_lo_43,子_193_do); 
         ObjectSetInteger(0,临_st_42,OBJPROP_COLOR,临_ui_44); 
         ObjectSetInteger(0,临_st_42,OBJPROP_FILL,总_119_bo_B9C); 
       }
     }
     lizong_10(子_191_da,子_192_do,子_193_do,子_194_do,子_195_do,子_196_bo,子_190_in); 
     lizong_11(子_191_da,子_194_do,子_195_do,子_197_do,子_190_in); 
     
   }
   if ( 总_120_in_BA0 >  0 )
   {
     for (子_198_in=ObjectsTotal(-1) - 1 ; 子_198_in >= 0 ; 子_198_in --)
     {
       子_199_st = ObjectName(子_198_in) ;
       if ( StringFind(子_199_st,"CandlePoints_",0) == 0 )
       {
         子_200_da = (datetime)ObjectGet(子_199_st,0);
         子_201_in = iBarShift(NULL,总_234_in_E04,子_200_da,false) ;
         if ( ( 子_201_in < 0 || 子_201_in >= 子_189_in ) )
         {
           ObjectDelete(子_199_st); 
         }
       }
     }
   }
   lizong_34(); 
   lizong_36(); 
 }
 else
 {
   for (子_202_in=ObjectsTotal(-1) - 1 ; 子_202_in >= 0 ; 子_202_in --)
   {
     子_203_st = ObjectName(子_202_in) ;
     if ( StringFind(子_203_st,"CandlePoints_",0) == 0 )
     {
       ObjectDelete(子_203_st); 
     }
     if ( StringFind(子_203_st,"VolStats_",0) == 0 )
     {
       ObjectDelete(子_203_st); 
     }
     if ( StringFind(子_203_st,"VolWarning_",0) == 0 )
     {
       ObjectDelete(子_203_st); 
     }
     if ( StringFind(子_203_st,"VolProgress_",0) == 0 )
     {
       ObjectDelete(子_203_st); 
     }
     if ( StringFind(子_203_st,"VolTrend_",0) == 0 )
     {
       ObjectDelete(子_203_st); 
     }
   }
 }
 if ( ObjectFind("ToggleBtn_CandlePoints") != -1 )
 {
   ObjectSetInteger(0,"ToggleBtn_CandlePoints",OBJPROP_BGCOLOR,(总_233_bo_E00) ?Goldenrod:0x40342D ); 
   if ( 总_233_bo_E00 )
   {
     临_st_45 = "点数统计 [ON]";
   }
   else
   {
     临_st_45 = "点数统计 [OFF]";
   }
   ObjectSetString(0,"ToggleBtn_CandlePoints",OBJPROP_TEXT,临_st_45); 
 }
 
 if ( ObjectFind("ToggleBtn_LiveBar") != -1 )
 {
  
   ObjectSetInteger(0,"ToggleBtn_LiveBar",OBJPROP_BGCOLOR,(总_236_bo_E10) ?0xC4BF00:0x40342D ); 
   if ( 总_236_bo_E10 )
   {
     临_st_46 = "实时分析 [ON]";
   }
   else
   {
     临_st_46 = "实时分析 [OFF]";
   }
   ObjectSetString(0,"ToggleBtn_LiveBar",OBJPROP_TEXT,临_st_46); 
  
 }
 if ( 总_236_bo_E10 )
 {
  
   lizong_13(); 
 }
 else
 {
  
   for (子_204_in=ObjectsTotal(-1) - 1 ; 子_204_in >= 0 ; 子_204_in --)
   {
    
     子_205_st = ObjectName(子_204_in) ;
     if ( StringFind(子_205_st,"LiveBar_",0) == 0 )
     {
       ObjectDelete(子_205_st); 
     }
   }
 }
 if ( 总_156_bo_C63 && ShowPivot )
 {
   
   子_206_bo = false ;
   
   子_207_bo = false ;
   子_208_st = "" ;
   
   子_209_in = (总_77_in_AC0 == 1) ?1:0  ;
   if ( 子_209_in <  木_0_in )
   {
     if ( 总_5_do_78_ko[子_209_in]>0.0 )
     {
       子_206_bo = true ;
       子_208_st = "D信号（做多）" ;
     }
     else
     {
       if ( 总_6_do_AC_ko[子_209_in]>0.0 )
       {
         子_207_bo = true ;
         子_208_st = "K信号（做空）" ;
       }
     }
   }
   子_210_da = iTime(NULL,0,子_209_in) ;
   if ( ( 子_206_bo || 子_207_bo ) && 总_235_lo_E08 != 子_210_da )
   {
     总_235_lo_E08 = 子_210_da ;
     子_211_do = iOpen(NULL,PERIOD_D1,0) ;
     子_212_in = 1 ;
     子_213_da = iTime(NULL,PERIOD_D1,1) ;
     if ( 子_213_da != 0 )
     {
       子_214_in = TimeDayOfWeek(子_213_da) ;
       if ( 子_214_in == 0 )
       {
         子_212_in = 2 ;
       }
       子_215_do = iHigh(NULL,PERIOD_D1,子_212_in) ;
       子_216_do = iLow(NULL,PERIOD_D1,子_212_in) ;
       子_217_do = iClose(NULL,PERIOD_D1,子_212_in) ;
       if ( 子_215_do>0.0 && 子_216_do>0.0 && 子_217_do>0.0 )
       {
         子_218_do = (子_215_do + 子_216_do + 子_217_do) / 3.0 ;
         子_219_do = 子_218_do * 2.0 - 子_216_do ;
         子_220_do = 子_218_do * 2.0 - 子_215_do ;
         子_221_st = "极简提示您：" ;
         子_221_st="极简提示您：" + (" 出现 " + 子_208_st + " ！\n");
         子_221_st +="货币品种: " + Symbol() + "\n";
         子_221_st +="目前 D 只做多，K 只做空\n";
         子_221_st +="────────────────────\n";
         子_221_st +="日内开盘: " + DoubleToString(子_211_do,Digits) + "\n";
         子_221_st +="多空分界: " + DoubleToString(子_218_do,Digits) + "\n";
         子_221_st +="上方阻力: " + DoubleToString(子_219_do,Digits) + "\n";
         子_221_st +="下方支撑: " + DoubleToString(子_220_do,Digits);
         if ( AlertWithSound )
         {
           Alert(子_221_st); 
         }
         else
         {
           Print(子_221_st); 
         }
       }
     }
   }
 }
 
 lizong_21(); 
 
 if ( 总_274_bo_14C8 )
 {
  
   临_lo_47 = TimeCurrent();
   if ( 临_lo_47 - 总_278_lo_1538 >= 总_223_in_DD8 )
   {
     总_278_lo_1538 = 临_lo_47 ;
     for (临_in_48 = 0 ; 临_in_48 < 总_276_in_1500 ; 临_in_48=临_in_48 + 1)
     {
       if ( 临_in_48 >= ArraySize(总_275_st_14CC_ko) )
       {
         Print("错误：货币对数组索引越界 i=",临_in_48," 数组大小=",ArraySize(总_275_st_14CC_ko)); 
         break;
       }
       临_st_49 = 总_275_st_14CC_ko[临_in_48];
       for (临_in_50 = 0 ; 临_in_50 < 5 ; 临_in_50=临_in_50 + 1)
       {
         临_in_51 = 临_in_48 * 5 + 临_in_50;
         if ( 临_in_51 >= ArraySize(总_277_in_1504_ko) )
         {
           Print("错误：强度数组索引越界 index=",临_in_51," 数组大小=",ArraySize(总_277_in_1504_ko)); 
           break;
         }
         总_277_in_1504_ko[临_in_51] = lizong_27(临_st_49,子_222_in_si5[临_in_50]);
       }
     }
     lizong_28(); 
     lizong_29(); 
   }
 }
 else
 {
   
   lizong_28(); 
 }
 
 lizong_31(); 
 return(木_0_in); 
 }
//OnCalculate <<==--------   --------
 void OnDeinit( const int 木_0_in)
 {
  int       子_1_in;
  string    子_2_st;
//----- -----

 EventKillTimer(); 
 for (子_1_in=ObjectsTotal(-1) - 1 ; 子_1_in >= 0 ; 子_1_in --)
 {
   子_2_st = ObjectName(子_1_in) ;
   if ( ( StringFind(子_2_st,"EMA1_",0) == 0 || StringFind(子_2_st,"EMA2_",0) == 0 || StringFind(子_2_st,"Countdown_",0) == 0 || StringFind(子_2_st,"Pivot_",0) == 0 || StringFind(子_2_st,"Arrow_Buy_",0) == 0 || StringFind(子_2_st,"Arrow_Sell_",0) == 0 || StringFind(子_2_st,"CandlePoints_",0) == 0 || StringFind(子_2_st,"ToggleBtn_",0) == 0 || StringFind(子_2_st,"LiveBar_",0) == 0 || StringFind(子_2_st,"SR_",0) == 0 || StringFind(子_2_st,"Monitor_",0) == 0 || StringFind(子_2_st,"TopRight_",0) == 0 || StringFind(子_2_st,"B3L",0) == 0 ) )
   {
     ObjectDelete(子_2_st); 
   }
 }
 }
//OnDeinit <<==--------   --------
 void lizong_8( string 木_0_st,double 木_1_do,uint 木_2_ui,int 木_3_in,int 木_4_in,string 木_5_st)
 {
  datetime  子_1_da;
  datetime  子_2_da;
  datetime  子_3_da;
  int       子_4_in;
  int       子_5_in;
  int       子_6_in;
  string    子_7_st;
  int       子_8_in;
  datetime  子_9_da;
  double    子_10_do;
  double    子_11_do;
  double    子_12_do;
//----- -----

 
 子_1_da = iTime(NULL,0,0) ;
 
 子_2_da = 0 ;
 子_3_da = 0 ;
 子_4_in = (int)ChartGetInteger(0,100,0);
 
 if ( 子_4_in <= 0 )
 {
   子_4_in = 100 ;
 }
 子_5_in = (int)(子_4_in * 总_203_do_D78 / 100.0);
 子_6_in = (int)(子_4_in * 总_204_do_D80 / 100.0);
 if ( 子_5_in <  2 )
 {
   子_5_in = 2 ;
 }
 if ( 子_6_in <  5 )
 {
   子_6_in = 5 ;
 }
 子_2_da=子_1_da + PeriodSeconds(0) * 子_5_in;
 子_3_da=子_2_da + PeriodSeconds(0) * 子_6_in;
 if ( 子_2_da == 0 )
 {
   子_2_da=TimeCurrent() + PeriodSeconds(0) * 15;
 }
 if ( 子_3_da == 0 )
 {
   子_3_da=子_2_da + PeriodSeconds(0) * 50;
 }
 if ( ObjectFind(木_0_st) == -1 )
 {
   ObjectCreate(0,木_0_st,OBJ_TREND,0,子_2_da,木_1_do,子_3_da,木_1_do); 
   ObjectSetInteger(0,木_0_st,OBJPROP_COLOR,木_2_ui); 
   ObjectSetInteger(0,木_0_st,OBJPROP_WIDTH,木_3_in); 
   ObjectSetInteger(0,木_0_st,OBJPROP_STYLE,木_4_in); 
   ObjectSetInteger(0,木_0_st,OBJPROP_RAY_RIGHT,0); 
   ObjectSetInteger(0,木_0_st,OBJPROP_BACK,0x1); 
 }
 else
 {
   ObjectMove(0,木_0_st,0,子_2_da,木_1_do); 
   ObjectMove(0,木_0_st,1,子_3_da,木_1_do); 
   ObjectSetInteger(0,木_0_st,OBJPROP_RAY_RIGHT,0); 
 }
 子_7_st=木_0_st + "_Label";
 子_8_in = (int)(子_4_in * 总_211_do_DA0 / 100.0);
 if ( 子_8_in <  1 )
 {
   子_8_in = 1 ;
 }
 子_9_da=iTime(NULL,0,0) + PeriodSeconds(0) * 子_8_in;
 子_10_do = iATR(Symbol(),0,总_74_in_AB0,0) ;
 if ( 子_10_do<=0.0 )
 {
   子_10_do = Point * 100.0 ;
 }
 子_11_do = 子_10_do * 0.01 ;
 子_12_do = 木_1_do - 子_11_do ;
 if ( ObjectFind(子_7_st) == -1 )
 {
   ObjectCreate(0,子_7_st,OBJ_TEXT,0,子_9_da,子_12_do); 
   ObjectSetString(0,子_7_st,OBJPROP_FONT,总_68_st_A88); 
   ObjectSetInteger(0,子_7_st,OBJPROP_FONTSIZE,总_114_in_B88); 
   ObjectSetInteger(0,子_7_st,OBJPROP_COLOR,木_2_ui); 
   ObjectSetInteger(0,子_7_st,OBJPROP_ANCHOR,0); 
 }
 ObjectSetString(0,子_7_st,OBJPROP_TEXT,木_5_st); 
 ObjectMove(0,子_7_st,0,子_9_da,子_12_do); 
 }
//lizong_8 <<==--------   --------
 void lizong_9()
 {
  string    子_1_st;
  int       子_2_in;
  int       子_3_in;
  int       子_4_in;
  int       子_5_in;
//----- -----
 string     临_st_1;

 子_1_st = "ToggleBtn_CandlePoints" ;
 if ( ObjectFind(子_1_st) != -1 )
 {
   ObjectDelete(子_1_st); 
 }
 子_2_in = 320 ;
 子_3_in = 0 ;
 子_4_in = 120 ;
 子_5_in = 25 ;
 ObjectCreate(0,子_1_st,OBJ_BUTTON,0,0,0.0); 
 ObjectSetInteger(0,子_1_st,OBJPROP_XDISTANCE,0x140); 
 ObjectSetInteger(0,子_1_st,OBJPROP_YDISTANCE,0); 
 ObjectSetInteger(0,子_1_st,OBJPROP_XSIZE,0x78); 
 ObjectSetInteger(0,子_1_st,OBJPROP_YSIZE,0x19); 
 ObjectSetInteger(0,子_1_st,OBJPROP_CORNER,0); 
 ObjectSetInteger(0,子_1_st,OBJPROP_FONTSIZE,0x9); 
 ObjectSetString(0,子_1_st,OBJPROP_FONT,"Arial Bold"); 
 ObjectSetInteger(0,子_1_st,OBJPROP_BGCOLOR,(总_233_bo_E00) ?Goldenrod:0x40342D ); 
 ObjectSetInteger(0,子_1_st,OBJPROP_COLOR,0xFFFFFF); 
 ObjectSetInteger(0,子_1_st,OBJPROP_BORDER_COLOR,0); 
 ObjectSetInteger(0,子_1_st,OBJPROP_BACK,0); 
 ObjectSetInteger(0,子_1_st,OBJPROP_STATE,0); 
 ObjectSetInteger(0,子_1_st,OBJPROP_SELECTABLE,0); 
 ObjectSetInteger(0,子_1_st,OBJPROP_SELECTED,0); 
 if ( 总_233_bo_E00 )
 {
   临_st_1 = "点数统计 [ON]";
 }
 else
 {
   临_st_1 = "点数统计 [OFF]";
 }
 ObjectSetString(0,子_1_st,OBJPROP_TEXT,临_st_1); 
 }
//lizong_9 <<==--------   --------
 void lizong_10( datetime 木_0_da,double 木_1_do,double 木_2_do,double 木_3_do,double 木_4_do,bool 木_5_bo,int 木_6_in)
 {
  int       子_1_in;
  datetime  子_2_da;
  uint      子_3_ui;
  string    子_4_st;
  double    子_5_do;
  string    子_6_st;
  double    子_7_do;
//----- -----

 if ( 木_0_da == 0 || 木_3_do<=0.0 || 木_4_do<=0.0 || 木_3_do<木_4_do )   return;
 子_1_in=总_234_in_E04 * 60;
 子_2_da=木_0_da + 子_1_in / 2;
 子_3_ui = (木_5_bo) ?总_117_ui_B94:总_118_ui_B98  ;
 子_4_st="CandlePoints_WICK_UP_" + TimeToString(木_0_da,3);
 子_5_do = MathMax(木_1_do,木_2_do) ;
 if ( ObjectFind(子_4_st) == -1 )
 {
   ObjectCreate(0,子_4_st,OBJ_TREND,0,子_2_da,木_3_do,子_2_da,子_5_do); 
   ObjectSetInteger(0,子_4_st,OBJPROP_COLOR,子_3_ui); 
   ObjectSetInteger(0,子_4_st,OBJPROP_WIDTH,0x1); 
   ObjectSetInteger(0,子_4_st,10,0); 
   ObjectSetInteger(0,子_4_st,OBJPROP_SELECTABLE,0); 
   ObjectSetInteger(0,子_4_st,OBJPROP_SELECTED,0); 
 }
 else
 {
   ObjectMove(0,子_4_st,0,子_2_da,木_3_do); 
   ObjectMove(0,子_4_st,1,子_2_da,子_5_do); 
   ObjectSetInteger(0,子_4_st,OBJPROP_COLOR,子_3_ui); 
 }
 子_6_st="CandlePoints_WICK_DN_" + TimeToString(木_0_da,3);
 子_7_do = MathMin(木_1_do,木_2_do) ;
 if ( ObjectFind(子_6_st) == -1 )
 {
   ObjectCreate(0,子_6_st,OBJ_TREND,0,子_2_da,子_7_do,子_2_da,木_4_do); 
   ObjectSetInteger(0,子_6_st,OBJPROP_COLOR,子_3_ui); 
   ObjectSetInteger(0,子_6_st,OBJPROP_WIDTH,0x1); 
   ObjectSetInteger(0,子_6_st,10,0); 
   ObjectSetInteger(0,子_6_st,OBJPROP_SELECTABLE,0); 
   ObjectSetInteger(0,子_6_st,OBJPROP_SELECTED,0); 
 }
 else
 {
   ObjectMove(0,子_6_st,0,子_2_da,子_7_do); 
   ObjectMove(0,子_6_st,1,子_2_da,木_4_do); 
   ObjectSetInteger(0,子_6_st,OBJPROP_COLOR,子_3_ui); 
 }
 }
//lizong_10 <<==--------   --------
 void lizong_11( datetime 木_0_da,double 木_1_do,double 木_2_do,double 木_3_do,int 木_4_in)
 {
  string    子_1_st;
  double    子_2_do;
  int       子_3_in;
  datetime  子_4_da;
  string    子_5_st;
  double    子_6_do;
  double    子_7_do;
  double    子_8_do;
  double    子_9_do;
  uint      子_10_ui;
  int       子_11_in;
  string    子_12_st;
  double    子_13_do;
  double    子_14_do;
  string    子_15_st;
//----- -----

 
 if ( 木_0_da == 0 || 木_1_do<=0.0 || 木_2_do<=0.0 || 木_1_do<木_2_do || 木_3_do<0.0 )   return;
 
 
 子_1_st="CandlePoints_LABEL_" + TimeToString(木_0_da,3);
 
 子_2_do = (木_1_do + 木_2_do) / 2.0 ;
 子_3_in=总_234_in_E04 * 60;
 子_4_da=木_0_da + 子_3_in / 2;
 子_5_st = "" ;
 if ( 总_123_bo_BB5 && 木_4_in <  iBars(NULL,总_234_in_E04) - 1 )
 {
   子_6_do = iHigh(NULL,总_234_in_E04,木_4_in + 1) ;
   子_7_do = iLow(NULL,总_234_in_E04,木_4_in + 1) ;
   if ( 子_6_do>0.0 && 子_7_do>0.0 && Point>0.0 )
   {
     子_8_do = (子_6_do - 子_7_do) / Point ;
     if ( 子_8_do>0.0 )
     {
       子_9_do = (木_3_do - 子_8_do) / 子_8_do * 100.0 ;
       if ( 子_9_do>30.0 )
       {
         子_5_st = "↑↑" ;
       }
       else
       {
         if ( 子_9_do>15.0 )
         {
           子_5_st = "↑" ;
         }
         else
         {
           if ( 子_9_do<-30.0 )
           {
             子_5_st = "↓↓" ;
           }
           else
           {
             if ( 子_9_do<-15.0 )
             {
               子_5_st = "↓" ;
             }
           }
         }
       }
     }
   }
 }
 
 子_10_ui = 总_130_ui_BD8 ;
 
 子_11_in = 总_134_in_BE8 ;
 
 子_12_st = "Arial" ;
 
 if ( 总_122_bo_BB4 )
 {
   
   子_13_do = 总_242_do_E40 ;
   
   if ( 子_13_do>0.0 )
   {
     
     子_14_do = 木_3_do / 子_13_do ;
     
     if ( 子_14_do<0.6 )
     {
       
       子_10_ui = 总_129_ui_BD4 ;
     }
     else
     {
       if ( 子_14_do<1.0 )
       {
        
         子_10_ui = 总_130_ui_BD8 ;
       }
       else
       {
         if ( 子_14_do<1.5 )
         {
           
           子_10_ui = 总_131_ui_BDC ;
         }
         else
         {
           
           子_10_ui = 总_132_ui_BE0 ;
           
           子_11_in +=2;
           
           子_12_st = "Arial Black" ;
         }
       }
     }
   }
 }
 
 if ( ObjectFind(子_1_st) == -1 )
 {
   
   ObjectCreate(0,子_1_st,OBJ_TEXT,0,子_4_da,子_2_do); 
   
   ObjectSetString(0,子_1_st,OBJPROP_FONT,子_12_st); 
   
   ObjectSetInteger(0,子_1_st,OBJPROP_ANCHOR,0x8); 
   
   ObjectSetInteger(0,子_1_st,OBJPROP_BACK,0); 
  
   ObjectSetInteger(0,子_1_st,OBJPROP_SELECTABLE,0); 
   
   ObjectSetInteger(0,子_1_st,OBJPROP_SELECTED,0); 
 }
 else
 {
  
   ObjectMove(0,子_1_st,0,子_4_da,子_2_do); 
   ObjectSetString(0,子_1_st,OBJPROP_FONT,子_12_st); 
 }
 子_15_st = DoubleToString(木_3_do,0) + 子_5_st ;
 ObjectSetString(0,子_1_st,OBJPROP_TEXT,子_15_st); 
 ObjectSetInteger(0,子_1_st,OBJPROP_FONTSIZE,子_11_in); 
 ObjectSetInteger(0,子_1_st,OBJPROP_COLOR,子_10_ui); 
 }
//lizong_11 <<==--------   --------
 void lizong_12()
 {
  string    子_1_st;
  int       子_2_in;
  int       子_3_in;
  int       子_4_in;
  int       子_5_in;
//----- -----
 string     临_st_1;

 子_1_st = "ToggleBtn_LiveBar" ;
 if ( ObjectFind(子_1_st) != -1 )
 {
   ObjectDelete(子_1_st); 
 }
 子_2_in = 440 ;
 子_3_in = 0 ;
 子_4_in = 120 ;
 子_5_in = 25 ;
 ObjectCreate(0,子_1_st,OBJ_BUTTON,0,0,0.0); 
 ObjectSetInteger(0,子_1_st,OBJPROP_XDISTANCE,0x1B8); 
 ObjectSetInteger(0,子_1_st,OBJPROP_YDISTANCE,0); 
 ObjectSetInteger(0,子_1_st,OBJPROP_XSIZE,0x78); 
 ObjectSetInteger(0,子_1_st,OBJPROP_YSIZE,0x19); 
 ObjectSetInteger(0,子_1_st,OBJPROP_CORNER,0); 
 ObjectSetInteger(0,子_1_st,OBJPROP_FONTSIZE,0x9); 
 ObjectSetString(0,子_1_st,OBJPROP_FONT,"Arial Bold"); 
 ObjectSetInteger(0,子_1_st,OBJPROP_BGCOLOR,(总_236_bo_E10) ?0xC4BF00:0x40342D ); 
 ObjectSetInteger(0,子_1_st,OBJPROP_COLOR,0xFFFFFF); 
 ObjectSetInteger(0,子_1_st,OBJPROP_BORDER_COLOR,0); 
 ObjectSetInteger(0,子_1_st,OBJPROP_BACK,0); 
 ObjectSetInteger(0,子_1_st,OBJPROP_STATE,0); 
 ObjectSetInteger(0,子_1_st,OBJPROP_SELECTABLE,0); 
 ObjectSetInteger(0,子_1_st,OBJPROP_SELECTED,0); 
 if ( 总_236_bo_E10 )
 {
   临_st_1 = "实时分析 [ON]";
 }
 else
 {
   临_st_1 = "实时分析 [OFF]";
 }
 ObjectSetString(0,子_1_st,OBJPROP_TEXT,临_st_1); 
 }
//lizong_12 <<==--------   --------
 void lizong_13()
 {
  string    子_1_st_si17[17]={"LiveBar_Alert_BG" , "LiveBar_Strength_Title" , "LiveBar_Strength" , "LiveBar_Levels_Title" , "LiveBar_SR_Title" , "LiveBar_SR_R" , "LiveBar_SR_R_Info" , "LiveBar_SR_S" , "LiveBar_SR_S_Info" , "LiveBar_SR_Center" , "LiveBar_SR_EMA" , "LiveBar_SR" , "LiveBar_SR_Dist" , "LiveBar_SR_Touch" , "LiveBar_Pivot" , "LiveBar_Fast1" , "LiveBar_Fast2"} ;
  int       子_2_in;
  int       子_3_in;
  uint      子_4_ui;
  uint      子_5_ui;
  uint      子_6_ui;
  uint      子_7_ui;
  string    子_8_st;
  int       子_9_in;
  uint      子_10_ui;
  string    子_11_st;
  double    子_12_do;
  double    子_13_do;
  double    子_14_do;
  double    子_15_do;
  double    子_16_do;
  double    子_17_do;
  double    子_18_do;
  double    子_19_do;
  double    子_20_do;
  double    子_21_do;
  double    子_22_do;
  double    子_23_do;
  double    子_24_do;
  double    子_25_do;
  double    子_26_do;
  double    子_27_do;
  double    子_28_do;
  double    子_29_do;
  double    子_30_do;
  int       子_31_in;
  string    子_32_st;
  int       子_33_in;
  double    子_34_do;
  double    子_35_do;
  int       子_36_in;
  datetime  子_37_da;
  int       子_38_in;
  double    子_39_do;
  double    子_40_do;
  double    子_41_do;
  int       子_42_in;
  int       子_43_in;
  int       子_44_in;
  uint      子_45_ui;
  uint      子_46_ui;
  uint      子_47_ui;
  uint      子_48_ui;
  bool      子_49_bo;
  uint      子_50_ui;
  string    子_51_st;
  string    子_52_st;
  double    子_53_do;
  bool      子_54_bo;
  uint      子_55_ui;
  string    子_56_st;
  string    子_57_st;
  double    子_58_do;
  bool      子_59_bo;
  uint      子_60_ui;
  uint      子_61_ui;
  string    子_62_st;
  string    子_63_st;
  uint      子_64_ui;
  string    子_65_st;
  string    子_66_st;
  uint      子_67_ui;
  double    子_68_do;
  int       子_69_in;
  int       子_70_in;
  double    子_71_do;
  double    子_72_do;
  int       子_73_in;
  double    子_74_do;
  double    子_75_do;
  double    子_76_do;
  uint      子_77_ui;
  string    子_78_st;
  string    子_79_st;
  int       子_80_in;
  string    子_81_st;
  string    子_82_st;
  string    子_83_st;
  double    子_84_do;
  uint      子_85_ui;
  string    子_86_st;
  string    子_87_st;
  int       子_88_in;
  string    子_89_st;
  string    子_90_st;
  string    子_91_st;
  double    子_92_do;
  string    子_93_st;
  uint      子_94_ui;
  double    子_95_do;
  bool      子_96_bo;
  uint      子_97_ui;
  string    子_98_st;
  string    子_99_st;
  string    子_100_st;
  int       子_101_in;
  string    子_102_st;
  bool      子_103_bo;
  uint      子_104_ui;
  string    子_105_st;
  bool      子_106_bo;
  uint      子_107_ui;
  string    子_108_st;
  bool      子_109_bo;
  uint      子_110_ui;
  string    子_111_st;
  bool      子_112_bo;
  string    子_113_st;
  string    子_114_st;
  uint      子_115_ui;
  double    子_116_do;
  string    子_117_st;
  uint      子_118_ui;
//----- -----
 bool       临_bo_1;
 int        临_in_2;
 int        临_in_3;
 double     临_do_4;
 double     临_do_5;
 double     临_do_6;
 int        临_in_7;
 int        临_in_8;
 double     临_do_9;
 int        临_in_10;
 int        临_in_11;
 bool       临_bo_12;
 uint       临_ui_13;
 int        临_in_14;
 string     临_st_15;
 int        临_in_16;
 int        临_in_17;
 string     临_st_18;
 bool       临_bo_19;
 uint       临_ui_20;
 int        临_in_21;
 string     临_st_22;
 int        临_in_23;
 int        临_in_24;
 string     临_st_25;
 bool       临_bo_26;
 uint       临_ui_27;
 uint       临_ui_28;
 int        临_in_29;
 string     临_st_30;
 int        临_in_31;
 int        临_in_32;
 string     临_st_33;
 bool       临_bo_34;
 uint       临_ui_35;
 int        临_in_36;
 string     临_st_37;
 int        临_in_38;
 int        临_in_39;
 string     临_st_40;
 bool       临_bo_41;
 uint       临_ui_42;
 uint       临_ui_43;
 int        临_in_44;
 string     临_st_45;
 int        临_in_46;
 int        临_in_47;
 string     临_st_48;
 uint       临_ui_49;
 bool       临_bo_50;
 uint       临_ui_51;
 int        临_in_52;
 string     临_st_53;
 int        临_in_54;
 int        临_in_55;
 string     临_st_56;
 bool       临_bo_57;
 uint       临_ui_58;
 int        临_in_59;
 string     临_st_60;
 int        临_in_61;
 int        临_in_62;
 string     临_st_63;
 bool       临_bo_64;
 uint       临_ui_65;
 int        临_in_66;
 string     临_st_67;
 int        临_in_68;
 int        临_in_69;
 string     临_st_70;
 string     临_st_71;
 string     临_st_72;
 uint       临_ui_73;
 bool       临_bo_74;
 uint       临_ui_75;
 int        临_in_76;
 string     临_st_77;
 int        临_in_78;
 int        临_in_79;
 string     临_st_80;
 bool       临_bo_81;
 uint       临_ui_82;
 uint       临_ui_83;
 int        临_in_84;
 string     临_st_85;
 int        临_in_86;
 int        临_in_87;
 string     临_st_88;
 bool       临_bo_89;
 uint       临_ui_90;
 int        临_in_91;
 string     临_st_92;
 int        临_in_93;
 int        临_in_94;
 string     临_st_95;
 bool       临_bo_96;
 uint       临_ui_97;
 int        临_in_98;
 string     临_st_99;
 int        临_in_100;
 int        临_in_101;
 string     临_st_102;
 string     临_st_103;
 bool       临_bo_104;
 uint       临_ui_105;
 int        临_in_106;
 string     临_st_107;
 int        临_in_108;
 int        临_in_109;
 string     临_st_110;
 string     临_st_111;
 int        临_in_112;
 string     临_st_113;
 bool       临_bo_114;
 uint       临_ui_115;
 uint       临_ui_116;
 int        临_in_117;
 int        临_in_118;
 int        临_in_119;
 string     临_st_120;
 string     临_st_121;
 bool       临_bo_122;
 uint       临_ui_123;
 int        临_in_124;
 string     临_st_125;
 int        临_in_126;
 int        临_in_127;
 string     临_st_128;
 string     临_st_129;
 int        临_in_130;
 string     临_st_131;
 bool       临_bo_132;
 uint       临_ui_133;
 uint       临_ui_134;
 int        临_in_135;
 int        临_in_136;
 int        临_in_137;
 string     临_st_138;
 bool       临_bo_139;
 uint       临_ui_140;
 int        临_in_141;
 string     临_st_142;
 int        临_in_143;
 int        临_in_144;
 string     临_st_145;
 bool       临_bo_146;
 uint       临_ui_147;
 uint       临_ui_148;
 int        临_in_149;
 string     临_st_150;
 int        临_in_151;
 int        临_in_152;
 string     临_st_153;
 double     临_do_154;
 string     临_st_155;
 bool       临_bo_156;
 uint       临_ui_157;
 int        临_in_158;
 string     临_st_159;
 int        临_in_160;
 int        临_in_161;
 string     临_st_162;
 bool       临_bo_163;
 uint       临_ui_164;
 int        临_in_165;
 string     临_st_166;
 int        临_in_167;
 int        临_in_168;
 string     临_st_169;
 bool       临_bo_170;
 uint       临_ui_171;
 uint       临_ui_172;
 int        临_in_173;
 string     临_st_174;
 int        临_in_175;
 int        临_in_176;
 string     临_st_177;
 bool       临_bo_178;
 uint       临_ui_179;
 int        临_in_180;
 string     临_st_181;
 int        临_in_182;
 int        临_in_183;
 string     临_st_184;
 bool       临_bo_185;
 uint       临_ui_186;
 int        临_in_187;
 string     临_st_188;
 int        临_in_189;
 int        临_in_190;
 string     临_st_191;
 bool       临_bo_192;
 uint       临_ui_193;
 int        临_in_194;
 string     临_st_195;
 int        临_in_196;
 int        临_in_197;
 string     临_st_198;
 bool       临_bo_199;
 uint       临_ui_200;
 int        临_in_201;
 string     临_st_202;
 int        临_in_203;
 int        临_in_204;
 string     临_st_205;
 double     临_do_206;
 string     临_st_207;
 uint       临_ui_208;
 bool       临_bo_209;
 uint       临_ui_210;
 int        临_in_211;
 string     临_st_212;
 int        临_in_213;
 int        临_in_214;
 string     临_st_215;

 for (子_2_in = 0 ; 子_2_in < ArraySize(子_1_st_si17) ; 子_2_in ++)
 {
   if ( ObjectFind(子_1_st_si17[子_2_in]) != -1 )
   {
     ObjectDelete(子_1_st_si17[子_2_in]); 
   }
 }
 临_bo_1 = 总_26_do_4BC_ko[0]!=INT_MAX;
 if ( 总_23_do_420_ko[0]!=INT_MAX )
 {
   临_in_2 = 1;
 }
 else
 {
   if ( 总_24_do_454_ko[0]!=INT_MAX )
   {
     临_in_2 = 2;
   }
   else
   {
     if ( 临_bo_1 )
     {
       临_in_2 = 3;
     }
     else
     {
       if ( 总_25_do_488_ko[0]!=INT_MAX )
       {
         临_in_2 = 4;
       }
       else
       {
         临_in_2 = 0;
       }
     }
   }
 }
 子_3_in = 临_in_2 ;
 子_4_ui = 0 ;
 子_5_ui = 0 ;
 子_6_ui = 0 ;
 子_7_ui = 0 ;
 临_in_3 = 子_3_in;
 
 子_7_ui = 0x37322D;

 if ( !(总_164_bo_C84) )
 {
  
   子_4_ui = 总_169_ui_CA0;
   子_5_ui = 总_170_ui_CA4;
   子_6_ui = 总_171_ui_CA8;
   子_7_ui = 总_168_ui_C9C;
 }
 else
 {
   switch(临_in_3)
   {
     case 1 :
     子_4_ui = 0x232350;
     子_5_ui = 0x323264;
     子_6_ui = 0x46468C;
       break;
     case 2 :
     子_4_ui = 0x323C1E;
     子_5_ui = 0x415028;
     子_6_ui = 0x5A783C;
       break;
     case 3 :
     子_4_ui = 0x37322D;
     子_5_ui = 0x46413C;
     子_6_ui = 0x645F5A;
       break;
     case 4 :
     子_4_ui = 0x1E3C46;
     子_5_ui = 0x2D505A;
     子_6_ui = 0x46788C;
       break;
     default :
     子_4_ui = 0x342A23;
     子_5_ui = 0x3E342D;
     子_6_ui = 0x5F5046;
   }
 }
 子_8_st = "LiveBar_Panel_BG" ;
 if ( ObjectFind(子_8_st) == -1 )
 {
   ObjectCreate(0,子_8_st,OBJ_RECTANGLE_LABEL,0,0,0.0); 
   ObjectSetInteger(0,子_8_st,OBJPROP_XDISTANCE,LiveBarPanelX); 
   ObjectSetInteger(0,子_8_st,OBJPROP_YDISTANCE,LiveBarPanelY); 
   ObjectSetInteger(0,子_8_st,OBJPROP_XSIZE,LiveBarPanelWidth); 
   ObjectSetInteger(0,子_8_st,OBJPROP_YSIZE,LiveBarPanelHeight); 
   ObjectSetInteger(0,子_8_st,OBJPROP_CORNER,0); 
   ObjectSetInteger(0,子_8_st,OBJPROP_BORDER_TYPE,0); 
   ObjectSetInteger(0,子_8_st,OBJPROP_WIDTH,0x1); 
   ObjectSetInteger(0,子_8_st,OBJPROP_BACK,0); 
   ObjectSetInteger(0,子_8_st,OBJPROP_SELECTABLE,0); 
 }
 子_9_in = MathMin(MathMax(总_165_in_C88,0),255) ;
 子_10_ui = (子_7_ui & 0xFFFFFF) | (子_9_in << 0x18);
 ObjectSetInteger(0,子_8_st,OBJPROP_BGCOLOR,子_10_ui); 
 ObjectSetInteger(0,子_8_st,OBJPROP_COLOR,子_6_ui); 
 ObjectSetInteger(0,子_8_st,OBJPROP_XSIZE,LiveBarPanelWidth); 
 ObjectSetInteger(0,子_8_st,OBJPROP_YSIZE,LiveBarPanelHeight); 
 if ( 子_3_in == 4 && 总_166_bo_C8C )
 {
   总_300_in_16AC=(总_300_in_16AC + 1) % 10;
   if ( 总_300_in_16AC >= 5 )
   {
     ObjectSetInteger(0,子_8_st,OBJPROP_COLOR,子_7_ui); 
   }
   else
   {
     ObjectSetInteger(0,子_8_st,OBJPROP_COLOR,子_6_ui); 
   }
 }
 子_11_st = "LiveBar_Title_BG" ;
 if ( ObjectFind(子_11_st) == -1 )
 {
   ObjectCreate(0,子_11_st,OBJ_RECTANGLE_LABEL,0,0,0.0); 
   ObjectSetInteger(0,子_11_st,OBJPROP_XDISTANCE,LiveBarPanelX); 
   ObjectSetInteger(0,子_11_st,OBJPROP_YDISTANCE,LiveBarPanelY); 
   ObjectSetInteger(0,子_11_st,OBJPROP_XSIZE,LiveBarPanelWidth); 
   ObjectSetInteger(0,子_11_st,OBJPROP_YSIZE,0x18); 
   ObjectSetInteger(0,子_11_st,OBJPROP_BORDER_TYPE,0); 
   ObjectSetInteger(0,子_11_st,OBJPROP_CORNER,0); 
   ObjectSetInteger(0,子_11_st,OBJPROP_BACK,0); 
   ObjectSetInteger(0,子_11_st,OBJPROP_SELECTABLE,0); 
 }
 ObjectSetInteger(0,子_11_st,OBJPROP_XSIZE,LiveBarPanelWidth); 
 ObjectSetInteger(0,子_11_st,OBJPROP_BGCOLOR,子_4_ui); 
 子_12_do = iOpen(NULL,0,0) ;
 子_13_do = iHigh(NULL,0,0) ;
 子_14_do = iLow(NULL,0,0) ;
 子_15_do = iClose(NULL,0,0) ;
 子_16_do = iMA(NULL,0,总_56_in_A54,0,1,0,0) ;
 子_17_do = iMA(NULL,0,总_57_in_A58,0,1,0,0) ;
 子_18_do = iMA(NULL,0,总_62_in_A6C,0,1,0,0) ;
 子_19_do = iMA(NULL,0,总_63_in_A70,0,1,0,0) ;
 子_20_do = iATR(NULL,0,总_85_in_AF8,0) ;
 子_21_do = (子_15_do - 子_16_do) / Point ;
 子_22_do = (子_15_do - 子_17_do) / Point ;
 子_23_do = (子_15_do - 子_18_do) / Point ;
 子_24_do = (子_15_do - 子_19_do) / Point ;
 子_25_do = (子_16_do - 子_17_do) / Point ;
 子_26_do = (子_18_do - 子_19_do) / Point ;
 子_27_do = (MathAbs(子_15_do - 子_12_do)) / Point ;
 子_28_do = (子_13_do - 子_14_do) / Point ;
 子_29_do = (子_13_do - MathMax(子_12_do,子_15_do)) / Point ;
 子_30_do = (MathMin(子_12_do,子_15_do) - 子_14_do) / Point ;
 子_31_in = lizong_14() ;
 子_32_st = lizong_15() ;
 临_do_4 = 子_20_do;
 临_do_5 = 子_28_do;
 临_do_6 = 子_27_do;
 
 if ( ( 临_do_6<0.0 || 临_do_5<0.0 || 临_do_4<0.0 ) )
 {
   临_in_7 = 50;
 }
 else
 {
   
   if ( 临_do_4<=0.000001 )
   {
     临_do_4 = (临_do_5>0.0) ?临_do_5:0.000001 ;
   }
   if ( 临_do_4<=0.000001 )
   {
     临_in_7 = 50;
   }
   else
   {
    
     临_in_8 = 50;
     临_in_8=临_in_8 + int((临_do_6 / (临_do_4) * 30.0 >= 30) ?30.0:临_do_6 / (临_do_4) * 30.0 );
     if ( 临_do_5>0.000001 )
     {
       临_in_8=临_in_8 + int(临_do_6 / 临_do_5 * 20.0);
     }
     if ( 临_do_4>0.000001 )
     {
       临_do_9 = 临_do_5 / (临_do_4);
       if ( 临_do_9>0.5 && 临_do_9<1.5 )
       {
         临_in_8=临_in_8 + 10;
       }
       else
       {
         if ( 临_do_9>2.0 )
         {
           临_in_8=临_in_8 - 10;
         }
       }
     }
     临_in_10 = 临_in_8;
     if ( 临_in_8 <= 0 )
     {
       临_in_11 = 0;
     }
     else
     {
       临_in_11 = 临_in_10;
     }
     临_in_7 = MathMin(临_in_11,100);
   }
 }
 子_33_in = 临_in_7 ;
 子_34_do = 0.0 ;
 子_35_do = 0.0 ;
 子_36_in = 1 ;
 子_37_da = iTime(NULL,PERIOD_D1,1) ;
 if ( 子_37_da != 0 )
 {
   子_38_in = TimeDayOfWeek(子_37_da) ;
   if ( 子_38_in == 0 )
   {
     子_36_in = 2 ;
   }
   子_39_do = iHigh(NULL,PERIOD_D1,子_36_in) ;
   子_40_do = iLow(NULL,PERIOD_D1,子_36_in) ;
   子_41_do = iClose(NULL,PERIOD_D1,子_36_in) ;
   if ( 子_39_do>0.0 && 子_40_do>0.0 && 子_41_do>0.0 )
   {
     子_34_do = (子_39_do + 子_40_do + 子_41_do) / 3.0 ;
     子_35_do = (子_15_do - 子_34_do) / Point ;
   }
 }
 临_bo_12 = true;
 临_ui_13 = White;
 临_in_14 = LiveBarFontSize + 2;
 临_st_15 = "       【实时K线智能分析】";
 临_in_16 = LiveBarPanelX + 10;
 临_in_17 = LiveBarPanelY + 2;
 if ( ObjectFind("LiveBar_Title") == -1 )
 {
   ObjectCreate(0,"LiveBar_Title",OBJ_LABEL,0,0,0.0); 
   ObjectSetInteger(0,"LiveBar_Title",OBJPROP_CORNER,0); 
   ObjectSetInteger(0,"LiveBar_Title",OBJPROP_ANCHOR,0); 
   ObjectSetInteger(0,"LiveBar_Title",OBJPROP_SELECTABLE,0); 
   ObjectSetInteger(0,"LiveBar_Title",OBJPROP_BACK,0); 
 }
 ObjectSetInteger(0,"LiveBar_Title",OBJPROP_XDISTANCE,临_in_16); 
 ObjectSetInteger(0,"LiveBar_Title",OBJPROP_YDISTANCE,临_in_17); 
 ObjectSetString(0,"LiveBar_Title",OBJPROP_TEXT,临_st_15); 
 if ( 临_bo_12 )
 {
   临_st_18 = "Arial Bold";
 }
 else
 {
   临_st_18 = 总_68_st_A88;
 }
 ObjectSetString(0,"LiveBar_Title",OBJPROP_FONT,临_st_18); 
 ObjectSetInteger(0,"LiveBar_Title",OBJPROP_FONTSIZE,临_in_14); 
 ObjectSetInteger(0,"LiveBar_Title",OBJPROP_COLOR,临_ui_13); 
 子_42_in = 28 ;
 子_43_in = 总_162_in_C70 ;
 子_44_in = (int)(总_162_in_C70 * 0.5);
 子_45_ui = (总_161_bo_C6E) ?总_177_ui_CD4:总_178_ui_CD8  ;
 子_46_ui = (总_161_bo_C6E) ?总_178_ui_CD8:总_177_ui_CD4  ;
 子_47_ui = (总_161_bo_C6E) ?总_179_ui_CDC:总_180_ui_CE0  ;
 子_48_ui = (总_161_bo_C6E) ?总_180_ui_CE0:总_179_ui_CDC  ;
 子_49_bo=子_16_do>子_17_do;
 子_50_ui = (子_49_bo) ?子_45_ui:子_46_ui  ;
 子_51_st = (子_49_bo) ?"多头排列":"空头排列"  ;
 子_52_st = (子_49_bo) ?"▲":"▼"  ;
 临_bo_19 = true;
 临_ui_20 = 子_50_ui;
 临_in_21 = LiveBarFontSize;
 临_st_22 = 子_52_st + " 第一组(" + IntegerToString(总_56_in_A54,0,32) + "/" + IntegerToString(总_57_in_A58,0,32) + "): " + 子_51_st;
 临_in_23 = LiveBarPanelX + 10;
 临_in_24 = LiveBarPanelY + 子_42_in;
 if ( ObjectFind("LiveBar_EMA1") == -1 )
 {
   ObjectCreate(0,"LiveBar_EMA1",OBJ_LABEL,0,0,0.0); 
   ObjectSetInteger(0,"LiveBar_EMA1",OBJPROP_CORNER,0); 
   ObjectSetInteger(0,"LiveBar_EMA1",OBJPROP_ANCHOR,0); 
   ObjectSetInteger(0,"LiveBar_EMA1",OBJPROP_SELECTABLE,0); 
   ObjectSetInteger(0,"LiveBar_EMA1",OBJPROP_BACK,0); 
 }
 ObjectSetInteger(0,"LiveBar_EMA1",OBJPROP_XDISTANCE,临_in_23); 
 ObjectSetInteger(0,"LiveBar_EMA1",OBJPROP_YDISTANCE,临_in_24); 
 ObjectSetString(0,"LiveBar_EMA1",OBJPROP_TEXT,临_st_22); 
 if ( 临_bo_19 )
 {
   临_st_25 = "Arial Bold";
 }
 else
 {
   临_st_25 = 总_68_st_A88;
 }
 ObjectSetString(0,"LiveBar_EMA1",OBJPROP_FONT,临_st_25); 
 ObjectSetInteger(0,"LiveBar_EMA1",OBJPROP_FONTSIZE,临_in_21); 
 ObjectSetInteger(0,"LiveBar_EMA1",OBJPROP_COLOR,临_ui_20); 
 子_42_in +=子_43_in;
 子_53_do = 0.0 ;
 if ( 子_17_do>0.000001 && Point>0.000001 )
 {
   子_53_do = (MathAbs(子_25_do)) * Point / 子_17_do * 100.0 ;
 }
 临_bo_26 = false;
 switch(3)
 {
   case 1 :
   临_ui_27 = 总_173_ui_CBC;
     break;
   case 2 :
   临_ui_27 = 总_174_ui_CC0;
     break;
   case 3 :
   临_ui_27 = 总_175_ui_CC4;
     break;
   default :
   临_ui_27 = 总_174_ui_CC0;
 }
 临_ui_28 = 临_ui_27;
 临_in_29 = LiveBarFontSize - 1;
 临_st_30 = "  ├ 快慢差: " + DoubleToString(子_25_do,1) + " 点 (" + DoubleToString(子_53_do,2) + "%)";
 临_in_31 = LiveBarPanelX + 10;
 临_in_32 = LiveBarPanelY + 子_42_in;
 if ( ObjectFind("LiveBar_EMA1_Gap") == -1 )
 {
   ObjectCreate(0,"LiveBar_EMA1_Gap",OBJ_LABEL,0,0,0.0); 
   ObjectSetInteger(0,"LiveBar_EMA1_Gap",OBJPROP_CORNER,0); 
   ObjectSetInteger(0,"LiveBar_EMA1_Gap",OBJPROP_ANCHOR,0); 
   ObjectSetInteger(0,"LiveBar_EMA1_Gap",OBJPROP_SELECTABLE,0); 
   ObjectSetInteger(0,"LiveBar_EMA1_Gap",OBJPROP_BACK,0); 
 }
 ObjectSetInteger(0,"LiveBar_EMA1_Gap",OBJPROP_XDISTANCE,临_in_31); 
 ObjectSetInteger(0,"LiveBar_EMA1_Gap",OBJPROP_YDISTANCE,临_in_32); 
 ObjectSetString(0,"LiveBar_EMA1_Gap",OBJPROP_TEXT,临_st_30); 
 if ( 临_bo_26 )
 {
   临_st_33 = "Arial Bold";
 }
 else
 {
   临_st_33 = 总_68_st_A88;
 }
 ObjectSetString(0,"LiveBar_EMA1_Gap",OBJPROP_FONT,临_st_33); 
 ObjectSetInteger(0,"LiveBar_EMA1_Gap",OBJPROP_FONTSIZE,临_in_29); 
 ObjectSetInteger(0,"LiveBar_EMA1_Gap",OBJPROP_COLOR,临_ui_28); 
 子_42_in +=子_43_in;
 子_54_bo=子_18_do>子_19_do;
 子_55_ui = (子_54_bo) ?子_45_ui:子_46_ui  ;
 子_56_st = (子_54_bo) ?"多头排列":"空头排列"  ;
 子_57_st = (子_54_bo) ?"▲":"▼"  ;
 临_bo_34 = true;
 临_ui_35 = 子_55_ui;
 临_in_36 = LiveBarFontSize;
 临_st_37 = 子_57_st + " 第二组(" + IntegerToString(总_62_in_A6C,0,32) + "/" + IntegerToString(总_63_in_A70,0,32) + "): " + 子_56_st;
 临_in_38 = LiveBarPanelX + 10;
 临_in_39 = LiveBarPanelY + 子_42_in;
 if ( ObjectFind("LiveBar_EMA2") == -1 )
 {
   ObjectCreate(0,"LiveBar_EMA2",OBJ_LABEL,0,0,0.0); 
   ObjectSetInteger(0,"LiveBar_EMA2",OBJPROP_CORNER,0); 
   ObjectSetInteger(0,"LiveBar_EMA2",OBJPROP_ANCHOR,0); 
   ObjectSetInteger(0,"LiveBar_EMA2",OBJPROP_SELECTABLE,0); 
   ObjectSetInteger(0,"LiveBar_EMA2",OBJPROP_BACK,0); 
 }
 ObjectSetInteger(0,"LiveBar_EMA2",OBJPROP_XDISTANCE,临_in_38); 
 ObjectSetInteger(0,"LiveBar_EMA2",OBJPROP_YDISTANCE,临_in_39); 
 ObjectSetString(0,"LiveBar_EMA2",OBJPROP_TEXT,临_st_37); 
 if ( 临_bo_34 )
 {
   临_st_40 = "Arial Bold";
 }
 else
 {
   临_st_40 = 总_68_st_A88;
 }
 ObjectSetString(0,"LiveBar_EMA2",OBJPROP_FONT,临_st_40); 
 ObjectSetInteger(0,"LiveBar_EMA2",OBJPROP_FONTSIZE,临_in_36); 
 ObjectSetInteger(0,"LiveBar_EMA2",OBJPROP_COLOR,临_ui_35); 
 子_42_in +=子_43_in;
 子_58_do = 0.0 ;
 if ( 子_19_do>0.000001 && Point>0.000001 )
 {
   子_58_do = (MathAbs(子_26_do)) * Point / 子_19_do * 100.0 ;
 }
 临_bo_41 = false;
 switch(3)
 {
   case 1 :
   临_ui_42 = 总_173_ui_CBC;
     break;
   case 2 :
   临_ui_42 = 总_174_ui_CC0;
     break;
   case 3 :
   临_ui_42 = 总_175_ui_CC4;
     break;
   default :
   临_ui_42 = 总_174_ui_CC0;
 }
 临_ui_43 = 临_ui_42;
 临_in_44 = LiveBarFontSize - 1;
 临_st_45 = "  ├ 快慢差: " + DoubleToString(子_26_do,1) + " 点 (" + DoubleToString(子_58_do,2) + "%)";
 临_in_46 = LiveBarPanelX + 10;
 临_in_47 = LiveBarPanelY + 子_42_in;
 if ( ObjectFind("LiveBar_EMA2_Gap") == -1 )
 {
   ObjectCreate(0,"LiveBar_EMA2_Gap",OBJ_LABEL,0,0,0.0); 
   ObjectSetInteger(0,"LiveBar_EMA2_Gap",OBJPROP_CORNER,0); 
   ObjectSetInteger(0,"LiveBar_EMA2_Gap",OBJPROP_ANCHOR,0); 
   ObjectSetInteger(0,"LiveBar_EMA2_Gap",OBJPROP_SELECTABLE,0); 
   ObjectSetInteger(0,"LiveBar_EMA2_Gap",OBJPROP_BACK,0); 
 }
 ObjectSetInteger(0,"LiveBar_EMA2_Gap",OBJPROP_XDISTANCE,临_in_46); 
 ObjectSetInteger(0,"LiveBar_EMA2_Gap",OBJPROP_YDISTANCE,临_in_47); 
 ObjectSetString(0,"LiveBar_EMA2_Gap",OBJPROP_TEXT,临_st_45); 
 if ( 临_bo_41 )
 {
   临_st_48 = "Arial Bold";
 }
 else
 {
   临_st_48 = 总_68_st_A88;
 }
 ObjectSetString(0,"LiveBar_EMA2_Gap",OBJPROP_FONT,临_st_48); 
 ObjectSetInteger(0,"LiveBar_EMA2_Gap",OBJPROP_FONTSIZE,临_in_44); 
 ObjectSetInteger(0,"LiveBar_EMA2_Gap",OBJPROP_COLOR,临_ui_43); 
 子_42_in +=子_43_in;
 子_42_in +=子_44_in;
 if ( 子_32_st != "" )
 {
   子_59_bo = StringFind(子_32_st,"金叉",0)!=-1 ;
   子_60_ui = (子_59_bo) ?子_45_ui:子_46_ui  ;
   if ( 总_161_bo_C6E )
   {
     临_ui_49 = (子_59_bo) ?0x2D2D46:0x37462D ;
   }
   else
   {
     临_ui_49 = (子_59_bo) ?0x37462D:0x2D2D46 ;
   }
   子_61_ui = 临_ui_49 ;
   ObjectDelete("LiveBar_Alert_BG"); 
   ObjectDelete("LiveBar_Alert"); 
   子_62_st = "LiveBar_Alert_BG" ;
   ObjectCreate(0,子_62_st,OBJ_RECTANGLE_LABEL,0,0,0.0); 
   ObjectSetInteger(0,子_62_st,OBJPROP_CORNER,0); 
   ObjectSetInteger(0,子_62_st,OBJPROP_BACK,0); 
   ObjectSetInteger(0,子_62_st,OBJPROP_SELECTABLE,0); 
   ObjectSetInteger(0,子_62_st,OBJPROP_BORDER_TYPE,0); 
   ObjectSetInteger(0,子_62_st,OBJPROP_WIDTH,0x1); 
   ObjectSetInteger(0,子_62_st,OBJPROP_XDISTANCE,LiveBarPanelX + 8); 
   ObjectSetInteger(0,子_62_st,OBJPROP_YDISTANCE,LiveBarPanelY + 子_42_in - 2); 
   ObjectSetInteger(0,子_62_st,OBJPROP_XSIZE,LiveBarPanelWidth - 16); 
   ObjectSetInteger(0,子_62_st,OBJPROP_YSIZE,子_43_in + 2); 
   ObjectSetInteger(0,子_62_st,OBJPROP_BGCOLOR,子_61_ui); 
   ObjectSetInteger(0,子_62_st,OBJPROP_COLOR,子_60_ui); 
   临_bo_50 = true;
   临_ui_51 = 子_60_ui;
   临_in_52 = LiveBarFontSize + 1;
   临_st_53 = "!! " + 子_32_st;
   临_in_54 = LiveBarPanelX + 10;
   临_in_55 = LiveBarPanelY + 子_42_in;
   if ( ObjectFind("LiveBar_Alert") == -1 )
   {
     ObjectCreate(0,"LiveBar_Alert",OBJ_LABEL,0,0,0.0); 
     ObjectSetInteger(0,"LiveBar_Alert",OBJPROP_CORNER,0); 
     ObjectSetInteger(0,"LiveBar_Alert",OBJPROP_ANCHOR,0); 
     ObjectSetInteger(0,"LiveBar_Alert",OBJPROP_SELECTABLE,0); 
     ObjectSetInteger(0,"LiveBar_Alert",OBJPROP_BACK,0); 
   }
   ObjectSetInteger(0,"LiveBar_Alert",OBJPROP_XDISTANCE,临_in_54); 
   ObjectSetInteger(0,"LiveBar_Alert",OBJPROP_YDISTANCE,临_in_55); 
   ObjectSetString(0,"LiveBar_Alert",OBJPROP_TEXT,临_st_53); 
   if ( 临_bo_50 )
   {
     临_st_56 = "Arial Bold";
   }
   else
   {
     临_st_56 = 总_68_st_A88;
   }
   ObjectSetString(0,"LiveBar_Alert",OBJPROP_FONT,临_st_56); 
   ObjectSetInteger(0,"LiveBar_Alert",OBJPROP_FONTSIZE,临_in_52); 
   ObjectSetInteger(0,"LiveBar_Alert",OBJPROP_COLOR,临_ui_51); 
   子_42_in +=子_43_in + 子_44_in;
 }
 else
 {
   子_42_in +=子_44_in;
 }
 if ( 总_159_bo_C6C )
 {
   子_42_in +=子_44_in;
   临_bo_57 = true;
   临_ui_58 = DarkSlateGray;
   临_in_59 = LiveBarFontSize;
   临_st_60 = "━━━ 趋势强度 ━━━";
   临_in_61 = LiveBarPanelX + 10;
   临_in_62 = LiveBarPanelY + 子_42_in;
   if ( ObjectFind("LiveBar_Strength_Title") == -1 )
   {
     ObjectCreate(0,"LiveBar_Strength_Title",OBJ_LABEL,0,0,0.0); 
     ObjectSetInteger(0,"LiveBar_Strength_Title",OBJPROP_CORNER,0); 
     ObjectSetInteger(0,"LiveBar_Strength_Title",OBJPROP_ANCHOR,0); 
     ObjectSetInteger(0,"LiveBar_Strength_Title",OBJPROP_SELECTABLE,0); 
     ObjectSetInteger(0,"LiveBar_Strength_Title",OBJPROP_BACK,0); 
   }
   ObjectSetInteger(0,"LiveBar_Strength_Title",OBJPROP_XDISTANCE,临_in_61); 
   ObjectSetInteger(0,"LiveBar_Strength_Title",OBJPROP_YDISTANCE,临_in_62); 
   ObjectSetString(0,"LiveBar_Strength_Title",OBJPROP_TEXT,临_st_60); 
   if ( 临_bo_57 )
   {
     临_st_63 = "Arial Bold";
   }
   else
   {
     临_st_63 = 总_68_st_A88;
   }
   ObjectSetString(0,"LiveBar_Strength_Title",OBJPROP_FONT,临_st_63); 
   ObjectSetInteger(0,"LiveBar_Strength_Title",OBJPROP_FONTSIZE,临_in_59); 
   ObjectSetInteger(0,"LiveBar_Strength_Title",OBJPROP_COLOR,临_ui_58); 
   子_42_in +=子_43_in + int(子_44_in * 0.5);
   子_63_st = lizong_16(子_31_in) ;
   子_64_ui = lizong_17(子_31_in) ;
   临_bo_64 = true;
   临_ui_65 = 子_64_ui;
   临_in_66 = LiveBarFontSize + 1;
   临_st_67 = 子_63_st + " " + IntegerToString(MathAbs(子_31_in),0,32) + "%";
   临_in_68 = LiveBarPanelX + 10;
   临_in_69 = LiveBarPanelY + 子_42_in;
   if ( ObjectFind("LiveBar_Strength") == -1 )
   {
     ObjectCreate(0,"LiveBar_Strength",OBJ_LABEL,0,0,0.0); 
     ObjectSetInteger(0,"LiveBar_Strength",OBJPROP_CORNER,0); 
     ObjectSetInteger(0,"LiveBar_Strength",OBJPROP_ANCHOR,0); 
     ObjectSetInteger(0,"LiveBar_Strength",OBJPROP_SELECTABLE,0); 
     ObjectSetInteger(0,"LiveBar_Strength",OBJPROP_BACK,0); 
   }
   ObjectSetInteger(0,"LiveBar_Strength",OBJPROP_XDISTANCE,临_in_68); 
   ObjectSetInteger(0,"LiveBar_Strength",OBJPROP_YDISTANCE,临_in_69); 
   ObjectSetString(0,"LiveBar_Strength",OBJPROP_TEXT,临_st_67); 
   if ( 临_bo_64 )
   {
     临_st_70 = "Arial Bold";
   }
   else
   {
     临_st_70 = 总_68_st_A88;
   }
   ObjectSetString(0,"LiveBar_Strength",OBJPROP_FONT,临_st_70); 
   ObjectSetInteger(0,"LiveBar_Strength",OBJPROP_FONTSIZE,临_in_66); 
   ObjectSetInteger(0,"LiveBar_Strength",OBJPROP_COLOR,临_ui_65); 
   子_42_in +=子_43_in;
 }
 子_42_in +=子_44_in;
 子_65_st = "K线质量: " + IntegerToString(子_33_in,0,32) + "分" ;
 if ( 子_33_in >= 80 )
 {
   临_st_71 = " (优)";
 }
 else
 {
   if ( 子_33_in >= 60 )
   {
     临_st_72 = " (良)";
   }
   else
   {
     临_st_72 = (子_33_in >= 40) ?" (中)":" (差)" ;
   }
   临_st_71 = 临_st_72;
 }
 子_66_st = 临_st_71 ;
 if ( 子_33_in >= 70 )
 {
   临_ui_73 = DarkGreen;
 }
 else
 {
   临_ui_73 = (子_33_in >= 40) ?DarkOrange:DimGray ;
 }
 子_67_ui = 临_ui_73 ;
 临_bo_74 = true;
 临_ui_75 = 子_67_ui;
 临_in_76 = LiveBarFontSize;
 临_st_77 = 子_65_st + 子_66_st;
 临_in_78 = LiveBarPanelX + 10;
 临_in_79 = LiveBarPanelY + 子_42_in;
 if ( ObjectFind("LiveBar_Score") == -1 )
 {
   ObjectCreate(0,"LiveBar_Score",OBJ_LABEL,0,0,0.0); 
   ObjectSetInteger(0,"LiveBar_Score",OBJPROP_CORNER,0); 
   ObjectSetInteger(0,"LiveBar_Score",OBJPROP_ANCHOR,0); 
   ObjectSetInteger(0,"LiveBar_Score",OBJPROP_SELECTABLE,0); 
   ObjectSetInteger(0,"LiveBar_Score",OBJPROP_BACK,0); 
 }
 ObjectSetInteger(0,"LiveBar_Score",OBJPROP_XDISTANCE,临_in_78); 
 ObjectSetInteger(0,"LiveBar_Score",OBJPROP_YDISTANCE,临_in_79); 
 ObjectSetString(0,"LiveBar_Score",OBJPROP_TEXT,临_st_77); 
 if ( 临_bo_74 )
 {
   临_st_80 = "Arial Bold";
 }
 else
 {
   临_st_80 = 总_68_st_A88;
 }
 ObjectSetString(0,"LiveBar_Score",OBJPROP_FONT,临_st_80); 
 ObjectSetInteger(0,"LiveBar_Score",OBJPROP_FONTSIZE,临_in_76); 
 ObjectSetInteger(0,"LiveBar_Score",OBJPROP_COLOR,临_ui_75); 
 子_42_in +=子_43_in;
 子_68_do = 0.0 ;
 if ( 子_28_do>0.000001 )
 {
   子_68_do = 子_27_do / 子_28_do * 100.0 ;
 }
 临_bo_81 = false;
 switch(3)
 {
   case 1 :
   临_ui_82 = 总_173_ui_CBC;
     break;
   case 2 :
   临_ui_82 = 总_174_ui_CC0;
     break;
   case 3 :
   临_ui_82 = 总_175_ui_CC4;
     break;
   default :
   临_ui_82 = 总_174_ui_CC0;
 }
 临_ui_83 = 临_ui_82;
 临_in_84 = LiveBarFontSize - 1;
 临_st_85 = "  ├ 实体: " + DoubleToString(子_27_do,1) + " 点 (" + DoubleToString(子_68_do,1) + "%)";
 临_in_86 = LiveBarPanelX + 10;
 临_in_87 = LiveBarPanelY + 子_42_in;
 if ( ObjectFind("LiveBar_CandleBody") == -1 )
 {
   ObjectCreate(0,"LiveBar_CandleBody",OBJ_LABEL,0,0,0.0); 
   ObjectSetInteger(0,"LiveBar_CandleBody",OBJPROP_CORNER,0); 
   ObjectSetInteger(0,"LiveBar_CandleBody",OBJPROP_ANCHOR,0); 
   ObjectSetInteger(0,"LiveBar_CandleBody",OBJPROP_SELECTABLE,0); 
   ObjectSetInteger(0,"LiveBar_CandleBody",OBJPROP_BACK,0); 
 }
 ObjectSetInteger(0,"LiveBar_CandleBody",OBJPROP_XDISTANCE,临_in_86); 
 ObjectSetInteger(0,"LiveBar_CandleBody",OBJPROP_YDISTANCE,临_in_87); 
 ObjectSetString(0,"LiveBar_CandleBody",OBJPROP_TEXT,临_st_85); 
 if ( 临_bo_81 )
 {
   临_st_88 = "Arial Bold";
 }
 else
 {
   临_st_88 = 总_68_st_A88;
 }
 ObjectSetString(0,"LiveBar_CandleBody",OBJPROP_FONT,临_st_88); 
 ObjectSetInteger(0,"LiveBar_CandleBody",OBJPROP_FONTSIZE,临_in_84); 
 ObjectSetInteger(0,"LiveBar_CandleBody",OBJPROP_COLOR,临_ui_83); 
 子_42_in +=子_43_in;
 if ( 总_160_bo_C6D )
 {
   子_42_in +=子_44_in;
   临_bo_89 = true;
   临_ui_90 = DarkSlateGray;
   临_in_91 = LiveBarFontSize;
   临_st_92 = "━━━ 关键价位 ━━━";
   临_in_93 = LiveBarPanelX + 10;
   临_in_94 = LiveBarPanelY + 子_42_in;
   if ( ObjectFind("LiveBar_Levels_Title") == -1 )
   {
     ObjectCreate(0,"LiveBar_Levels_Title",OBJ_LABEL,0,0,0.0); 
     ObjectSetInteger(0,"LiveBar_Levels_Title",OBJPROP_CORNER,0); 
     ObjectSetInteger(0,"LiveBar_Levels_Title",OBJPROP_ANCHOR,0); 
     ObjectSetInteger(0,"LiveBar_Levels_Title",OBJPROP_SELECTABLE,0); 
     ObjectSetInteger(0,"LiveBar_Levels_Title",OBJPROP_BACK,0); 
   }
   ObjectSetInteger(0,"LiveBar_Levels_Title",OBJPROP_XDISTANCE,临_in_93); 
   ObjectSetInteger(0,"LiveBar_Levels_Title",OBJPROP_YDISTANCE,临_in_94); 
   ObjectSetString(0,"LiveBar_Levels_Title",OBJPROP_TEXT,临_st_92); 
   if ( 临_bo_89 )
   {
     临_st_95 = "Arial Bold";
   }
   else
   {
     临_st_95 = 总_68_st_A88;
   }
   ObjectSetString(0,"LiveBar_Levels_Title",OBJPROP_FONT,临_st_95); 
   ObjectSetInteger(0,"LiveBar_Levels_Title",OBJPROP_FONTSIZE,临_in_91); 
   ObjectSetInteger(0,"LiveBar_Levels_Title",OBJPROP_COLOR,临_ui_90); 
   子_42_in +=子_43_in;
   if ( 总_182_bo_CF4 && 总_222_bo_DD7 )
   {
     临_bo_96 = true;
     临_ui_97 = Gold;
     临_in_98 = LiveBarFontSize;
     临_st_99 = "=== 智能SR位 ===";
     临_in_100 = LiveBarPanelX + 10;
     临_in_101 = LiveBarPanelY + 子_42_in;
     if ( ObjectFind("LiveBar_SR_Title") == -1 )
     {
       ObjectCreate(0,"LiveBar_SR_Title",OBJ_LABEL,0,0,0.0); 
       ObjectSetInteger(0,"LiveBar_SR_Title",OBJPROP_CORNER,0); 
       ObjectSetInteger(0,"LiveBar_SR_Title",OBJPROP_ANCHOR,0); 
       ObjectSetInteger(0,"LiveBar_SR_Title",OBJPROP_SELECTABLE,0); 
       ObjectSetInteger(0,"LiveBar_SR_Title",OBJPROP_BACK,0); 
     }
     ObjectSetInteger(0,"LiveBar_SR_Title",OBJPROP_XDISTANCE,临_in_100); 
     ObjectSetInteger(0,"LiveBar_SR_Title",OBJPROP_YDISTANCE,临_in_101); 
     ObjectSetString(0,"LiveBar_SR_Title",OBJPROP_TEXT,临_st_99); 
     if ( 临_bo_96 )
     {
       临_st_102 = "Arial Bold";
     }
     else
     {
       临_st_102 = 总_68_st_A88;
     }
     ObjectSetString(0,"LiveBar_SR_Title",OBJPROP_FONT,临_st_102); 
     ObjectSetInteger(0,"LiveBar_SR_Title",OBJPROP_FONTSIZE,临_in_98); 
     ObjectSetInteger(0,"LiveBar_SR_Title",OBJPROP_COLOR,临_ui_97); 
     子_42_in +=子_43_in;
     子_69_in = -1 ;
     子_70_in = -1 ;
     子_71_do = DBL_MAX ;
     子_72_do = DBL_MAX ;
     for (子_73_in = 0 ; 子_73_in < 7 ; 子_73_in ++)
     {
       if ( 总_262_in_1208_si7[子_73_in] == 0 )   continue;
       子_74_do = 子_15_do - 总_254_do_F94_si7[子_73_in] ;
       if ( 子_74_do<0.0 )
       {
         子_75_do=MathAbs(子_74_do);
         if ( !(子_75_do<子_72_do) )   continue;
         子_72_do = 子_75_do ;
         子_70_in = 子_73_in ;
          continue;
       }
       if ( !(子_74_do>0.0) || !(子_74_do<子_71_do) )   continue;
       子_71_do = 子_74_do ;
       子_69_in = 子_73_in ;
       
     }
     if ( 子_70_in >= 0 )
     {
       子_76_do = (子_15_do - 总_254_do_F94_si7[子_70_in]) / Point ;
       子_77_ui = 总_256_co_1088_si7[子_70_in] ;
       if ( 子_70_in >= 7 )
       {
         临_st_103 = "未知";
       }
       else
       {
         if ( 子_70_in == 0 )
         {
           临_st_103 = "中心线";
         }
         else
         {
           if ( 子_70_in >= 1 && 子_70_in <= 3 )
           {
             临_st_103 = "阻力" + IntegerToString(子_70_in,0,32);
           }
           else
           {
             临_st_103 = "支撑" + IntegerToString(子_70_in - 3,0,32);
           }
         }
       }
       子_78_st = 临_st_103 ;
       子_79_st = lizong_23(子_70_in) ;
       子_80_in = 总_257_in_10D8_si7[子_70_in] ;
       子_81_st = (总_259_bo_1194_si7[子_70_in]) ?" [突破!]":""  ;
       子_82_st = "" ;
       if ( 总_214_bo_DBC && 总_264_in_125C_si7[子_70_in] >= 2 )
       {
         子_82_st = " <!>" ;
       }
       临_bo_104 = true;
       临_ui_105 = 子_77_ui;
       临_in_106 = LiveBarFontSize;
       临_st_107 = "^ 最近阻力: " + 子_78_st + 子_79_st + 子_82_st;
       临_in_108 = LiveBarPanelX + 10;
       临_in_109 = LiveBarPanelY + 子_42_in;
       if ( ObjectFind("LiveBar_SR_R") == -1 )
       {
         ObjectCreate(0,"LiveBar_SR_R",OBJ_LABEL,0,0,0.0); 
         ObjectSetInteger(0,"LiveBar_SR_R",OBJPROP_CORNER,0); 
         ObjectSetInteger(0,"LiveBar_SR_R",OBJPROP_ANCHOR,0); 
         ObjectSetInteger(0,"LiveBar_SR_R",OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,"LiveBar_SR_R",OBJPROP_BACK,0); 
       }
       ObjectSetInteger(0,"LiveBar_SR_R",OBJPROP_XDISTANCE,临_in_108); 
       ObjectSetInteger(0,"LiveBar_SR_R",OBJPROP_YDISTANCE,临_in_109); 
       ObjectSetString(0,"LiveBar_SR_R",OBJPROP_TEXT,临_st_107); 
       if ( 临_bo_104 )
       {
         临_st_110 = "Arial Bold";
       }
       else
       {
         临_st_110 = 总_68_st_A88;
       }
       ObjectSetString(0,"LiveBar_SR_R",OBJPROP_FONT,临_st_110); 
       ObjectSetInteger(0,"LiveBar_SR_R",OBJPROP_FONTSIZE,临_in_106); 
       ObjectSetInteger(0,"LiveBar_SR_R",OBJPROP_COLOR,临_ui_105); 
       子_42_in +=子_43_in;
       子_83_st = "  距离: ^" + DoubleToString(MathAbs(子_76_do),1) + "点" ;
       if ( 总_207_bo_D95 && 子_80_in >  0 )
       {
         临_st_111=" | 触" + IntegerToString(子_80_in,0,32);
         临_in_112 = 子_80_in;
        
         临_st_113 = "";
         if ( 临_in_112 >= 10 )
         {
           临_st_113 = " ★★★";
         }
         else
         {
           if ( 临_in_112 >= 7 )
           {
             临_st_113 = " ★★";
           }
           else
           {
             if ( 临_in_112 >= 4 )
             {
               临_st_113 = " ★";
             }
             else
             {
               if ( 临_in_112 >= 1 )
               {
                 临_st_113 = " ☆";
               }
             }
           }
         }
         临_st_111=临_st_111 + 临_st_113;
         子_83_st +=临_st_111;
       }
       子_83_st +=子_81_st;
       临_bo_114 = false;
       switch(3)
       {
         case 1 :
         临_ui_115 = 总_173_ui_CBC;
           break;
         case 2 :
         临_ui_115 = 总_174_ui_CC0;
           break;
         case 3 :
         临_ui_115 = 总_175_ui_CC4;
           break;
         default :
         临_ui_115 = 总_174_ui_CC0;
       }
       临_ui_116 = 临_ui_115;
       临_in_117 = LiveBarFontSize - 1;
       临_st_111 = 子_83_st;
       临_in_118 = LiveBarPanelX + 10;
       临_in_119 = LiveBarPanelY + 子_42_in;
       if ( ObjectFind("LiveBar_SR_R_Info") == -1 )
       {
         ObjectCreate(0,"LiveBar_SR_R_Info",OBJ_LABEL,0,0,0.0); 
         ObjectSetInteger(0,"LiveBar_SR_R_Info",OBJPROP_CORNER,0); 
         ObjectSetInteger(0,"LiveBar_SR_R_Info",OBJPROP_ANCHOR,0); 
         ObjectSetInteger(0,"LiveBar_SR_R_Info",OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,"LiveBar_SR_R_Info",OBJPROP_BACK,0); 
       }
       ObjectSetInteger(0,"LiveBar_SR_R_Info",OBJPROP_XDISTANCE,临_in_118); 
       ObjectSetInteger(0,"LiveBar_SR_R_Info",OBJPROP_YDISTANCE,临_in_119); 
       ObjectSetString(0,"LiveBar_SR_R_Info",OBJPROP_TEXT,临_st_111); 
       if ( 临_bo_114 )
       {
         临_st_120 = "Arial Bold";
       }
       else
       {
         临_st_120 = 总_68_st_A88;
       }
       ObjectSetString(0,"LiveBar_SR_R_Info",OBJPROP_FONT,临_st_120); 
       ObjectSetInteger(0,"LiveBar_SR_R_Info",OBJPROP_FONTSIZE,临_in_117); 
       ObjectSetInteger(0,"LiveBar_SR_R_Info",OBJPROP_COLOR,临_ui_116); 
       子_42_in +=子_43_in;
     }
     if ( 子_69_in >= 0 )
     {
       子_84_do = (子_15_do - 总_254_do_F94_si7[子_69_in]) / Point ;
       子_85_ui = 总_256_co_1088_si7[子_69_in] ;
       if ( 子_69_in >= 7 )
       {
         临_st_121 = "未知";
       }
       else
       {
         if ( 子_69_in == 0 )
         {
           临_st_121 = "中心线";
         }
         else
         {
           if ( 子_69_in >= 1 && 子_69_in <= 3 )
           {
             临_st_121 = "阻力" + IntegerToString(子_69_in,0,32);
           }
           else
           {
             临_st_121 = "支撑" + IntegerToString(子_69_in - 3,0,32);
           }
         }
       }
       子_86_st = 临_st_121 ;
       子_87_st = lizong_23(子_69_in) ;
       子_88_in = 总_257_in_10D8_si7[子_69_in] ;
       子_89_st = (总_259_bo_1194_si7[子_69_in]) ?" [突破!]":""  ;
       子_90_st = "" ;
       if ( 总_214_bo_DBC && 总_264_in_125C_si7[子_69_in] >= 2 )
       {
         子_90_st = " <!>" ;
       }
       临_bo_122 = true;
       临_ui_123 = 子_85_ui;
       临_in_124 = LiveBarFontSize;
       临_st_125 = "v 最近支撑: " + 子_86_st + 子_87_st + 子_90_st;
       临_in_126 = LiveBarPanelX + 10;
       临_in_127 = LiveBarPanelY + 子_42_in;
       if ( ObjectFind("LiveBar_SR_S") == -1 )
       {
         ObjectCreate(0,"LiveBar_SR_S",OBJ_LABEL,0,0,0.0); 
         ObjectSetInteger(0,"LiveBar_SR_S",OBJPROP_CORNER,0); 
         ObjectSetInteger(0,"LiveBar_SR_S",OBJPROP_ANCHOR,0); 
         ObjectSetInteger(0,"LiveBar_SR_S",OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,"LiveBar_SR_S",OBJPROP_BACK,0); 
       }
       ObjectSetInteger(0,"LiveBar_SR_S",OBJPROP_XDISTANCE,临_in_126); 
       ObjectSetInteger(0,"LiveBar_SR_S",OBJPROP_YDISTANCE,临_in_127); 
       ObjectSetString(0,"LiveBar_SR_S",OBJPROP_TEXT,临_st_125); 
       if ( 临_bo_122 )
       {
         临_st_128 = "Arial Bold";
       }
       else
       {
         临_st_128 = 总_68_st_A88;
       }
       ObjectSetString(0,"LiveBar_SR_S",OBJPROP_FONT,临_st_128); 
       ObjectSetInteger(0,"LiveBar_SR_S",OBJPROP_FONTSIZE,临_in_124); 
       ObjectSetInteger(0,"LiveBar_SR_S",OBJPROP_COLOR,临_ui_123); 
       子_42_in +=子_43_in;
       子_91_st = "  距离: v" + DoubleToString(MathAbs(子_84_do),1) + "点" ;
       if ( 总_207_bo_D95 && 子_88_in >  0 )
       {
         临_st_129=" | 触" + IntegerToString(子_88_in,0,32);
         临_in_130 = 子_88_in;
         
         临_st_131 = "";
         if ( 临_in_130 >= 10 )
         {
           临_st_131 = " ★★★";
         }
         else
         {
           if ( 临_in_130 >= 7 )
           {
             临_st_131 = " ★★";
           }
           else
           {
             if ( 临_in_130 >= 4 )
             {
               临_st_131 = " ★";
             }
             else
             {
               if ( 临_in_130 >= 1 )
               {
                 临_st_131 = " ☆";
               }
             }
           }
         }
         临_st_129=临_st_129 + 临_st_131;
         子_91_st +=临_st_129;
       }
       子_91_st +=子_89_st;
       临_bo_132 = false;
       switch(3)
       {
         case 1 :
         临_ui_133 = 总_173_ui_CBC;
           break;
         case 2 :
         临_ui_133 = 总_174_ui_CC0;
           break;
         case 3 :
         临_ui_133 = 总_175_ui_CC4;
           break;
         default :
         临_ui_133 = 总_174_ui_CC0;
       }
       临_ui_134 = 临_ui_133;
       临_in_135 = LiveBarFontSize - 1;
       临_st_129 = 子_91_st;
       临_in_136 = LiveBarPanelX + 10;
       临_in_137 = LiveBarPanelY + 子_42_in;
       if ( ObjectFind("LiveBar_SR_S_Info") == -1 )
       {
         ObjectCreate(0,"LiveBar_SR_S_Info",OBJ_LABEL,0,0,0.0); 
         ObjectSetInteger(0,"LiveBar_SR_S_Info",OBJPROP_CORNER,0); 
         ObjectSetInteger(0,"LiveBar_SR_S_Info",OBJPROP_ANCHOR,0); 
         ObjectSetInteger(0,"LiveBar_SR_S_Info",OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,"LiveBar_SR_S_Info",OBJPROP_BACK,0); 
       }
       ObjectSetInteger(0,"LiveBar_SR_S_Info",OBJPROP_XDISTANCE,临_in_136); 
       ObjectSetInteger(0,"LiveBar_SR_S_Info",OBJPROP_YDISTANCE,临_in_137); 
       ObjectSetString(0,"LiveBar_SR_S_Info",OBJPROP_TEXT,临_st_129); 
       if ( 临_bo_132 )
       {
         临_st_138 = "Arial Bold";
       }
       else
       {
         临_st_138 = 总_68_st_A88;
       }
       ObjectSetString(0,"LiveBar_SR_S_Info",OBJPROP_FONT,临_st_138); 
       ObjectSetInteger(0,"LiveBar_SR_S_Info",OBJPROP_FONTSIZE,临_in_135); 
       ObjectSetInteger(0,"LiveBar_SR_S_Info",OBJPROP_COLOR,临_ui_134); 
       子_42_in +=子_43_in;
     }
     if ( 总_262_in_1208_si7[0] >  0 )
     {
       子_92_do = (子_15_do - 总_254_do_F94_si7[0]) / Point ;
       子_93_st = (子_92_do>0.0) ?"多头":"空头"  ;
       子_94_ui = (子_92_do>0.0) ?0x6464FF:0x78C864  ;
       临_bo_139 = false;
       临_ui_140 = 子_94_ui;
       临_in_141 = LiveBarFontSize;
       临_st_142 = "o 中心线: " + 子_93_st + " (" + DoubleToString(MathAbs(子_92_do),1) + "点)";
       临_in_143 = LiveBarPanelX + 10;
       临_in_144 = LiveBarPanelY + 子_42_in;
       if ( ObjectFind("LiveBar_SR_Center") == -1 )
       {
         ObjectCreate(0,"LiveBar_SR_Center",OBJ_LABEL,0,0,0.0); 
         ObjectSetInteger(0,"LiveBar_SR_Center",OBJPROP_CORNER,0); 
         ObjectSetInteger(0,"LiveBar_SR_Center",OBJPROP_ANCHOR,0); 
         ObjectSetInteger(0,"LiveBar_SR_Center",OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,"LiveBar_SR_Center",OBJPROP_BACK,0); 
       }
       ObjectSetInteger(0,"LiveBar_SR_Center",OBJPROP_XDISTANCE,临_in_143); 
       ObjectSetInteger(0,"LiveBar_SR_Center",OBJPROP_YDISTANCE,临_in_144); 
       ObjectSetString(0,"LiveBar_SR_Center",OBJPROP_TEXT,临_st_142); 
       if ( 临_bo_139 )
       {
         临_st_145 = "Arial Bold";
       }
       else
       {
         临_st_145 = 总_68_st_A88;
       }
       ObjectSetString(0,"LiveBar_SR_Center",OBJPROP_FONT,临_st_145); 
       ObjectSetInteger(0,"LiveBar_SR_Center",OBJPROP_FONTSIZE,临_in_141); 
       ObjectSetInteger(0,"LiveBar_SR_Center",OBJPROP_COLOR,临_ui_140); 
       子_42_in +=子_43_in;
     }
     if ( 总_219_bo_DD4 )
     {
       临_bo_146 = false;
       switch(3)
       {
         case 1 :
         临_ui_147 = 总_173_ui_CBC;
           break;
         case 2 :
         临_ui_147 = 总_174_ui_CC0;
           break;
         case 3 :
         临_ui_147 = 总_175_ui_CC4;
           break;
         default :
         临_ui_147 = 总_174_ui_CC0;
       }
       临_ui_148 = 临_ui_147;
       临_in_149 = LiveBarFontSize - 1;
       临_st_150 = "  基准EMA: " + DoubleToString(总_273_do_14C0,0);
       临_in_151 = LiveBarPanelX + 10;
       临_in_152 = LiveBarPanelY + 子_42_in;
       if ( ObjectFind("LiveBar_SR_EMA") == -1 )
       {
         ObjectCreate(0,"LiveBar_SR_EMA",OBJ_LABEL,0,0,0.0); 
         ObjectSetInteger(0,"LiveBar_SR_EMA",OBJPROP_CORNER,0); 
         ObjectSetInteger(0,"LiveBar_SR_EMA",OBJPROP_ANCHOR,0); 
         ObjectSetInteger(0,"LiveBar_SR_EMA",OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,"LiveBar_SR_EMA",OBJPROP_BACK,0); 
       }
       ObjectSetInteger(0,"LiveBar_SR_EMA",OBJPROP_XDISTANCE,临_in_151); 
       ObjectSetInteger(0,"LiveBar_SR_EMA",OBJPROP_YDISTANCE,临_in_152); 
       ObjectSetString(0,"LiveBar_SR_EMA",OBJPROP_TEXT,临_st_150); 
       if ( 临_bo_146 )
       {
         临_st_153 = "Arial Bold";
       }
       else
       {
         临_st_153 = 总_68_st_A88;
       }
       ObjectSetString(0,"LiveBar_SR_EMA",OBJPROP_FONT,临_st_153); 
       ObjectSetInteger(0,"LiveBar_SR_EMA",OBJPROP_FONTSIZE,临_in_149); 
       ObjectSetInteger(0,"LiveBar_SR_EMA",OBJPROP_COLOR,临_ui_148); 
       子_42_in +=子_43_in;
     }
   }
   else
   {
     if ( 总_182_bo_CF4 && 总_263_in_1224 >= 0 && 总_263_in_1224 <  7 )
     {
       if ( Point>0.0 )
       {
         临_do_154 = (子_15_do - 总_254_do_F94_si7[总_263_in_1224]) / Point;
       }
       else
       {
         临_do_154 = 0.0;
       }
       子_95_do = 临_do_154 ;
       子_96_bo=子_95_do>0.0;
       子_97_ui = 总_256_co_1088_si7[总_263_in_1224] ;
       子_98_st = (子_96_bo) ?"^":"v"  ;
       if ( ( 总_263_in_1224 < 0 || 总_263_in_1224 >= 7 ) )
       {
         临_st_155 = "未知";
       }
       else
       {
         if ( 总_263_in_1224 == 0 )
         {
           临_st_155 = "中心线";
         }
         else
         {
           if ( 总_263_in_1224 >= 1 && 总_263_in_1224 <= 3 )
           {
             临_st_155 = "阻力" + IntegerToString(总_263_in_1224,0,32);
           }
           else
           {
             临_st_155 = "支撑" + IntegerToString(总_263_in_1224 - 3,0,32);
           }
         }
       }
       子_99_st = 临_st_155 ;
       子_100_st = lizong_23(总_263_in_1224) ;
       子_101_in = 总_257_in_10D8_si7[总_263_in_1224] ;
       子_102_st = (总_259_bo_1194_si7[总_263_in_1224]) ?" [突破]":""  ;
       临_bo_156 = true;
       临_ui_157 = 子_97_ui;
       临_in_158 = LiveBarFontSize;
       临_st_159 = "* " + 子_99_st + " " + 子_100_st;
       临_in_160 = LiveBarPanelX + 10;
       临_in_161 = LiveBarPanelY + 子_42_in;
       if ( ObjectFind("LiveBar_SR") == -1 )
       {
         ObjectCreate(0,"LiveBar_SR",OBJ_LABEL,0,0,0.0); 
         ObjectSetInteger(0,"LiveBar_SR",OBJPROP_CORNER,0); 
         ObjectSetInteger(0,"LiveBar_SR",OBJPROP_ANCHOR,0); 
         ObjectSetInteger(0,"LiveBar_SR",OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,"LiveBar_SR",OBJPROP_BACK,0); 
       }
       ObjectSetInteger(0,"LiveBar_SR",OBJPROP_XDISTANCE,临_in_160); 
       ObjectSetInteger(0,"LiveBar_SR",OBJPROP_YDISTANCE,临_in_161); 
       ObjectSetString(0,"LiveBar_SR",OBJPROP_TEXT,临_st_159); 
       if ( 临_bo_156 )
       {
         临_st_162 = "Arial Bold";
       }
       else
       {
         临_st_162 = 总_68_st_A88;
       }
       ObjectSetString(0,"LiveBar_SR",OBJPROP_FONT,临_st_162); 
       ObjectSetInteger(0,"LiveBar_SR",OBJPROP_FONTSIZE,临_in_158); 
       ObjectSetInteger(0,"LiveBar_SR",OBJPROP_COLOR,临_ui_157); 
       子_42_in +=子_43_in;
       临_bo_163 = false;
       临_ui_164 = 子_97_ui;
       临_in_165 = LiveBarFontSize - 1;
       临_st_166 = "  距离: " + 子_98_st + " " + DoubleToString(MathAbs(子_95_do),1) + " 点" + 子_102_st;
       临_in_167 = LiveBarPanelX + 10;
       临_in_168 = LiveBarPanelY + 子_42_in;
       if ( ObjectFind("LiveBar_SR_Dist") == -1 )
       {
         ObjectCreate(0,"LiveBar_SR_Dist",OBJ_LABEL,0,0,0.0); 
         ObjectSetInteger(0,"LiveBar_SR_Dist",OBJPROP_CORNER,0); 
         ObjectSetInteger(0,"LiveBar_SR_Dist",OBJPROP_ANCHOR,0); 
         ObjectSetInteger(0,"LiveBar_SR_Dist",OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,"LiveBar_SR_Dist",OBJPROP_BACK,0); 
       }
       ObjectSetInteger(0,"LiveBar_SR_Dist",OBJPROP_XDISTANCE,临_in_167); 
       ObjectSetInteger(0,"LiveBar_SR_Dist",OBJPROP_YDISTANCE,临_in_168); 
       ObjectSetString(0,"LiveBar_SR_Dist",OBJPROP_TEXT,临_st_166); 
       if ( 临_bo_163 )
       {
         临_st_169 = "Arial Bold";
       }
       else
       {
         临_st_169 = 总_68_st_A88;
       }
       ObjectSetString(0,"LiveBar_SR_Dist",OBJPROP_FONT,临_st_169); 
       ObjectSetInteger(0,"LiveBar_SR_Dist",OBJPROP_FONTSIZE,临_in_165); 
       ObjectSetInteger(0,"LiveBar_SR_Dist",OBJPROP_COLOR,临_ui_164); 
       子_42_in +=子_43_in;
       临_bo_170 = false;
       switch(3)
       {
         case 1 :
         临_ui_171 = 总_173_ui_CBC;
           break;
         case 2 :
         临_ui_171 = 总_174_ui_CC0;
           break;
         case 3 :
         临_ui_171 = 总_175_ui_CC4;
           break;
         default :
         临_ui_171 = 总_174_ui_CC0;
       }
       临_ui_172 = 临_ui_171;
       临_in_173 = LiveBarFontSize - 1;
       临_st_174 = "  触碰: " + IntegerToString(子_101_in,0,32) + " 次";
       临_in_175 = LiveBarPanelX + 10;
       临_in_176 = LiveBarPanelY + 子_42_in;
       if ( ObjectFind("LiveBar_SR_Touch") == -1 )
       {
         ObjectCreate(0,"LiveBar_SR_Touch",OBJ_LABEL,0,0,0.0); 
         ObjectSetInteger(0,"LiveBar_SR_Touch",OBJPROP_CORNER,0); 
         ObjectSetInteger(0,"LiveBar_SR_Touch",OBJPROP_ANCHOR,0); 
         ObjectSetInteger(0,"LiveBar_SR_Touch",OBJPROP_SELECTABLE,0); 
         ObjectSetInteger(0,"LiveBar_SR_Touch",OBJPROP_BACK,0); 
       }
       ObjectSetInteger(0,"LiveBar_SR_Touch",OBJPROP_XDISTANCE,临_in_175); 
       ObjectSetInteger(0,"LiveBar_SR_Touch",OBJPROP_YDISTANCE,临_in_176); 
       ObjectSetString(0,"LiveBar_SR_Touch",OBJPROP_TEXT,临_st_174); 
       if ( 临_bo_170 )
       {
         临_st_177 = "Arial Bold";
       }
       else
       {
         临_st_177 = 总_68_st_A88;
       }
       ObjectSetString(0,"LiveBar_SR_Touch",OBJPROP_FONT,临_st_177); 
       ObjectSetInteger(0,"LiveBar_SR_Touch",OBJPROP_FONTSIZE,临_in_173); 
       ObjectSetInteger(0,"LiveBar_SR_Touch",OBJPROP_COLOR,临_ui_172); 
       子_42_in +=子_43_in;
     }
   }
   if ( 子_34_do>0.0 )
   {
     子_103_bo=子_35_do>0.0;
     子_104_ui = (子_103_bo) ?子_47_ui:子_48_ui  ;
     子_105_st = (子_103_bo) ?"↑":"↓"  ;
     临_bo_178 = false;
     临_ui_179 = 子_104_ui;
     临_in_180 = LiveBarFontSize;
     临_st_181 = "多空分界: " + 子_105_st + " " + DoubleToString(MathAbs(子_35_do),1) + " 点";
     临_in_182 = LiveBarPanelX + 10;
     临_in_183 = LiveBarPanelY + 子_42_in;
     if ( ObjectFind("LiveBar_Pivot") == -1 )
     {
       ObjectCreate(0,"LiveBar_Pivot",OBJ_LABEL,0,0,0.0); 
       ObjectSetInteger(0,"LiveBar_Pivot",OBJPROP_CORNER,0); 
       ObjectSetInteger(0,"LiveBar_Pivot",OBJPROP_ANCHOR,0); 
       ObjectSetInteger(0,"LiveBar_Pivot",OBJPROP_SELECTABLE,0); 
       ObjectSetInteger(0,"LiveBar_Pivot",OBJPROP_BACK,0); 
     }
     ObjectSetInteger(0,"LiveBar_Pivot",OBJPROP_XDISTANCE,临_in_182); 
     ObjectSetInteger(0,"LiveBar_Pivot",OBJPROP_YDISTANCE,临_in_183); 
     ObjectSetString(0,"LiveBar_Pivot",OBJPROP_TEXT,临_st_181); 
     if ( 临_bo_178 )
     {
       临_st_184 = "Arial Bold";
     }
     else
     {
       临_st_184 = 总_68_st_A88;
     }
     ObjectSetString(0,"LiveBar_Pivot",OBJPROP_FONT,临_st_184); 
     ObjectSetInteger(0,"LiveBar_Pivot",OBJPROP_FONTSIZE,临_in_180); 
     ObjectSetInteger(0,"LiveBar_Pivot",OBJPROP_COLOR,临_ui_179); 
     子_42_in +=子_43_in;
   }
   子_106_bo=子_21_do>0.0;
   子_107_ui = (子_106_bo) ?子_47_ui:子_48_ui  ;
   子_108_st = (子_106_bo) ?"↑":"↓"  ;
   临_bo_185 = false;
   临_ui_186 = 子_107_ui;
   临_in_187 = LiveBarFontSize - 1;
   临_st_188 = "  ├ 快线1(EMA" + IntegerToString(总_56_in_A54,0,32) + "): " + 子_108_st + " " + DoubleToString(MathAbs(子_21_do),1) + " 点";
   临_in_189 = LiveBarPanelX + 10;
   临_in_190 = LiveBarPanelY + 子_42_in;
   if ( ObjectFind("LiveBar_Fast1") == -1 )
   {
     ObjectCreate(0,"LiveBar_Fast1",OBJ_LABEL,0,0,0.0); 
     ObjectSetInteger(0,"LiveBar_Fast1",OBJPROP_CORNER,0); 
     ObjectSetInteger(0,"LiveBar_Fast1",OBJPROP_ANCHOR,0); 
     ObjectSetInteger(0,"LiveBar_Fast1",OBJPROP_SELECTABLE,0); 
     ObjectSetInteger(0,"LiveBar_Fast1",OBJPROP_BACK,0); 
   }
   ObjectSetInteger(0,"LiveBar_Fast1",OBJPROP_XDISTANCE,临_in_189); 
   ObjectSetInteger(0,"LiveBar_Fast1",OBJPROP_YDISTANCE,临_in_190); 
   ObjectSetString(0,"LiveBar_Fast1",OBJPROP_TEXT,临_st_188); 
   if ( 临_bo_185 )
   {
     临_st_191 = "Arial Bold";
   }
   else
   {
     临_st_191 = 总_68_st_A88;
   }
   ObjectSetString(0,"LiveBar_Fast1",OBJPROP_FONT,临_st_191); 
   ObjectSetInteger(0,"LiveBar_Fast1",OBJPROP_FONTSIZE,临_in_187); 
   ObjectSetInteger(0,"LiveBar_Fast1",OBJPROP_COLOR,临_ui_186); 
   子_42_in +=子_43_in;
   子_109_bo=子_23_do>0.0;
   子_110_ui = (子_109_bo) ?子_47_ui:子_48_ui  ;
   子_111_st = (子_109_bo) ?"↑":"↓"  ;
   临_bo_192 = false;
   临_ui_193 = 子_110_ui;
   临_in_194 = LiveBarFontSize - 1;
   临_st_195 = "  └ 快线2(EMA" + IntegerToString(总_62_in_A6C,0,32) + "): " + 子_111_st + " " + DoubleToString(MathAbs(子_23_do),1) + " 点";
   临_in_196 = LiveBarPanelX + 10;
   临_in_197 = LiveBarPanelY + 子_42_in;
   if ( ObjectFind("LiveBar_Fast2") == -1 )
   {
     ObjectCreate(0,"LiveBar_Fast2",OBJ_LABEL,0,0,0.0); 
     ObjectSetInteger(0,"LiveBar_Fast2",OBJPROP_CORNER,0); 
     ObjectSetInteger(0,"LiveBar_Fast2",OBJPROP_ANCHOR,0); 
     ObjectSetInteger(0,"LiveBar_Fast2",OBJPROP_SELECTABLE,0); 
     ObjectSetInteger(0,"LiveBar_Fast2",OBJPROP_BACK,0); 
   }
   ObjectSetInteger(0,"LiveBar_Fast2",OBJPROP_XDISTANCE,临_in_196); 
   ObjectSetInteger(0,"LiveBar_Fast2",OBJPROP_YDISTANCE,临_in_197); 
   ObjectSetString(0,"LiveBar_Fast2",OBJPROP_TEXT,临_st_195); 
   if ( 临_bo_192 )
   {
     临_st_198 = "Arial Bold";
   }
   else
   {
     临_st_198 = 总_68_st_A88;
   }
   ObjectSetString(0,"LiveBar_Fast2",OBJPROP_FONT,临_st_198); 
   ObjectSetInteger(0,"LiveBar_Fast2",OBJPROP_FONTSIZE,临_in_194); 
   ObjectSetInteger(0,"LiveBar_Fast2",OBJPROP_COLOR,临_ui_193); 
   子_42_in +=子_43_in;
 }
 子_42_in +=子_44_in;
 子_112_bo=子_15_do>子_12_do;
 子_113_st = (子_112_bo) ?"阳线":"阴线"  ;
 子_114_st = (子_112_bo) ?"▲":"▼"  ;
 子_115_ui = (子_112_bo) ?子_45_ui:子_46_ui  ;
 临_bo_199 = true;
 临_ui_200 = 子_115_ui;
 临_in_201 = LiveBarFontSize;
 临_st_202 = 子_114_st + " 形态: " + 子_113_st + "  范围: " + DoubleToString(子_28_do,1) + " 点";
 临_in_203 = LiveBarPanelX + 10;
 临_in_204 = LiveBarPanelY + 子_42_in;
 if ( ObjectFind("LiveBar_Type") == -1 )
 {
   ObjectCreate(0,"LiveBar_Type",OBJ_LABEL,0,0,0.0); 
   ObjectSetInteger(0,"LiveBar_Type",OBJPROP_CORNER,0); 
   ObjectSetInteger(0,"LiveBar_Type",OBJPROP_ANCHOR,0); 
   ObjectSetInteger(0,"LiveBar_Type",OBJPROP_SELECTABLE,0); 
   ObjectSetInteger(0,"LiveBar_Type",OBJPROP_BACK,0); 
 }
 ObjectSetInteger(0,"LiveBar_Type",OBJPROP_XDISTANCE,临_in_203); 
 ObjectSetInteger(0,"LiveBar_Type",OBJPROP_YDISTANCE,临_in_204); 
 ObjectSetString(0,"LiveBar_Type",OBJPROP_TEXT,临_st_202); 
 if ( 临_bo_199 )
 {
   临_st_205 = "Arial Bold";
 }
 else
 {
   临_st_205 = 总_68_st_A88;
 }
 ObjectSetString(0,"LiveBar_Type",OBJPROP_FONT,临_st_205); 
 ObjectSetInteger(0,"LiveBar_Type",OBJPROP_FONTSIZE,临_in_201); 
 ObjectSetInteger(0,"LiveBar_Type",OBJPROP_COLOR,临_ui_200); 
 子_42_in +=子_43_in;
 if ( 子_15_do>0.0 )
 {
   临_do_206 = 子_20_do / 子_15_do * 100.0;
 }
 else
 {
   临_do_206 = 0.0;
 }
 子_116_do = 临_do_206 ;
 if ( 子_116_do>0.5 )
 {
   临_st_207 = "高波动 €€";
 }
 else
 {
   临_st_207 = (子_116_do>0.2) ?"中等 ~":"低波动 -" ;
 }
 子_117_st = 临_st_207 ;
 if ( 子_116_do>0.5 )
 {
   临_ui_208 = OrangeRed;
 }
 else
 {
   临_ui_208 = (子_116_do>0.2) ?Goldenrod:Gray ;
 }
 子_118_ui = 临_ui_208 ;
 临_bo_209 = false;
 临_ui_210 = 子_118_ui;
 临_in_211 = LiveBarFontSize - 1;
 临_st_212 = "  └ 波动率: " + 子_117_st + " (ATR: " + DoubleToString(子_116_do,2) + "%)";
 临_in_213 = LiveBarPanelX + 10;
 临_in_214 = LiveBarPanelY + 子_42_in;
 if ( ObjectFind("LiveBar_Volatility") == -1 )
 {
   ObjectCreate(0,"LiveBar_Volatility",OBJ_LABEL,0,0,0.0); 
   ObjectSetInteger(0,"LiveBar_Volatility",OBJPROP_CORNER,0); 
   ObjectSetInteger(0,"LiveBar_Volatility",OBJPROP_ANCHOR,0); 
   ObjectSetInteger(0,"LiveBar_Volatility",OBJPROP_SELECTABLE,0); 
   ObjectSetInteger(0,"LiveBar_Volatility",OBJPROP_BACK,0); 
 }
 ObjectSetInteger(0,"LiveBar_Volatility",OBJPROP_XDISTANCE,临_in_213); 
 ObjectSetInteger(0,"LiveBar_Volatility",OBJPROP_YDISTANCE,临_in_214); 
 ObjectSetString(0,"LiveBar_Volatility",OBJPROP_TEXT,临_st_212); 
 if ( 临_bo_209 )
 {
   临_st_215 = "Arial Bold";
 }
 else
 {
   临_st_215 = 总_68_st_A88;
 }
 ObjectSetString(0,"LiveBar_Volatility",OBJPROP_FONT,临_st_215); 
 ObjectSetInteger(0,"LiveBar_Volatility",OBJPROP_FONTSIZE,临_in_211); 
 ObjectSetInteger(0,"LiveBar_Volatility",OBJPROP_COLOR,临_ui_210); 
 }
//lizong_13 <<==--------   --------
 int lizong_14()
 {
  double    子_2_do;
  double    子_3_do;
  double    子_4_do;
  double    子_5_do;
  double    子_6_do;
  double    子_7_do;
  int       子_8_in;
  double    子_9_do;
  double    子_10_do;
  double    子_11_do;
  double    子_12_do;
  double    子_13_do;
  double    子_14_do;
//----- -----
 double     临_do_1;
 double     临_do_2;
 double     临_do_3;
 double     临_do_4;
 double     临_do_5;

 子_2_do = iMA(NULL,0,总_56_in_A54,0,1,0,0) ;
 子_3_do = iMA(NULL,0,总_57_in_A58,0,1,0,0) ;
 子_4_do = iMA(NULL,0,总_62_in_A6C,0,1,0,0) ;
 子_5_do = iMA(NULL,0,总_63_in_A70,0,1,0,0) ;
 子_6_do = iClose(NULL,0,0) ;
 子_7_do = iATR(NULL,0,总_85_in_AF8,0) ;
 if ( ( 子_2_do<=0.0 || 子_3_do<=0.0 || 子_4_do<=0.0 || 子_5_do<=0.0 || 子_6_do<=0.0 ) )
 {
   return(0); 
 }
 if ( 子_7_do<=0.000001 )
 {
   if ( Point>0.0 )
   {
     临_do_1 = Point * 100.0;
   }
   else
   {
     临_do_1 = 0.00001;
   }
   子_7_do = 临_do_1 ;
 }
 if ( 子_7_do<=0.000001 )
 {
   return(0); 
 }
 子_8_in = 0 ;
 子_9_do = (子_2_do - 子_3_do) / 子_7_do ;
 if ( MathAbs(子_9_do)<1000.0 )
 {
   if ( (MathAbs(子_9_do)) * 30.0 >= 30 )
   {
     临_do_2 = 30.0;
   }
   else
   {
     临_do_2 = (MathAbs(子_9_do)) * 30.0;
   }
   子_8_in +=int(临_do_2 * ((子_9_do>0.0) ?1:-1 ));
 }
 子_10_do = (子_4_do - 子_5_do) / 子_7_do ;
 if ( MathAbs(子_10_do)<1000.0 )
 {
   if ( (MathAbs(子_10_do)) * 30.0 >= 30 )
   {
     临_do_3 = 30.0;
   }
   else
   {
     临_do_3 = (MathAbs(子_10_do)) * 30.0;
   }
   子_8_in +=int(临_do_3 * ((子_10_do>0.0) ?1:-1 ));
 }
 子_11_do = (子_2_do + 子_3_do + 子_4_do + 子_5_do) / 4.0 ;
 if ( 子_11_do>0.0 )
 {
   子_12_do = (子_6_do - 子_11_do) / 子_7_do ;
   if ( MathAbs(子_12_do)<1000.0 )
   {
     if ( (MathAbs(子_12_do)) * 20.0 >= 20 )
     {
       临_do_4 = 20.0;
     }
     else
     {
       临_do_4 = (MathAbs(子_12_do)) * 20.0;
     }
     子_8_in +=int(临_do_4 * ((子_12_do>0.0) ?1:-1 ));
   }
 }
 子_13_do = iClose(NULL,0,0) - iOpen(NULL,0,0) ;
 子_14_do = 子_13_do / 子_7_do * 20.0 ;
 if ( MathAbs(子_14_do)<1000.0 )
 {
   if ( 子_14_do <= -20 )
   {
     临_do_5 = -20.0;
   }
   else
   {
     临_do_5 = 子_14_do;
   }
   子_8_in +=int((临_do_5 >= 20) ?20.0:临_do_5 );
 }
 return(MathMin(MathMax(子_8_in,-100),100)); 
 }
//lizong_14 <<==--------   --------
 string lizong_15()
 {
  double    子_1_do;
  double    子_2_do;
  double    子_3_do;
  double    子_4_do;
  double    子_5_do;
  double    子_6_do;
  double    子_7_do;
  double    子_8_do;
  double    子_9_do;
  double    子_10_do;
  double    子_11_do;
  double    子_12_do;
  double    子_13_do;
  double    子_14_do;
  string    子_15_st;
  datetime  子_16_da;
  datetime  子_17_da;
//----- -----

 if ( !(总_157_bo_C64) )
 {
   return("");
 }
 子_1_do = iMA(NULL,0,总_56_in_A54,0,1,0,0) ;
 子_2_do = iMA(NULL,0,总_57_in_A58,0,1,0,0) ;
 子_3_do = iMA(NULL,0,总_62_in_A6C,0,1,0,0) ;
 子_4_do = iMA(NULL,0,总_63_in_A70,0,1,0,0) ;
 子_5_do = iMA(NULL,0,总_56_in_A54,0,1,0,1) ;
 子_6_do = iMA(NULL,0,总_57_in_A58,0,1,0,1) ;
 子_7_do = iMA(NULL,0,总_62_in_A6C,0,1,0,1) ;
 子_8_do = iMA(NULL,0,总_63_in_A70,0,1,0,1) ;
 子_9_do = 子_1_do - 子_2_do ;
 子_10_do = 子_5_do - 子_6_do ;
 子_11_do = 子_3_do - 子_4_do ;
 子_12_do = 子_7_do - 子_8_do ;
 子_13_do = iATR(NULL,0,总_85_in_AF8,0) ;
 子_14_do = 子_13_do * 0.2 ;
 子_15_st = "" ;
 if ( 子_12_do<0.0 && 子_11_do> -(子_14_do) && 子_11_do<子_14_do )
 {
   子_15_st = "即将金叉！(D信号)" ;
   子_16_da = iTime(NULL,0,0) ;
   if ( 总_237_lo_E18 != 子_16_da && AlertWithSound )
   {
     Alert("预警：",Symbol()," 第二组EMA即将金叉！"); 
     总_237_lo_E18 = 子_16_da ;
   }
 }
 else
 {
   if ( 子_12_do>0.0 && 子_11_do<子_14_do && 子_11_do> -(子_14_do) )
   {
     子_15_st = "即将死叉！(K信号)" ;
     子_17_da = iTime(NULL,0,0) ;
     if ( 总_237_lo_E18 != 子_17_da && AlertWithSound )
     {
       Alert("预警：",Symbol()," 第二组EMA即将死叉！"); 
       总_237_lo_E18 = 子_17_da ;
     }
   }
   else
   {
     if ( 子_10_do<0.0 && 子_9_do> -(子_14_do) && 子_9_do<子_14_do )
     {
       子_15_st = "第一组即将金叉 (b1)" ;
     }
     else
     {
       if ( 子_10_do>0.0 && 子_9_do<子_14_do && 子_9_do> -(子_14_do) )
       {
         子_15_st = "第一组即将死叉 (s1)" ;
       }
     }
   }
 }
 return(子_15_st);
 }
//lizong_15 <<==--------   --------
 string lizong_16( int 木_0_in)
 {
  int       子_1_in;
  int       子_2_in;
  bool      子_3_bo;
  string    子_4_st;
  string    子_5_st;
  string    子_6_st;
  string    子_7_st;
  string    子_8_st;
  int       子_9_in;
  int       子_10_in;
  int       子_11_in;
  int       子_12_in;
//----- -----


 子_1_in=MathAbs(木_0_in);
 子_2_in=子_1_in / 10;
 
 子_3_bo=木_0_in>0;
 子_4_st = "" ;
 
 子_5_st = "" ;
 
 if ( 子_1_in >= 80 )
 {
   子_4_st = "极强" ;
   子_5_st = "|||" ;
 }
 else
 {
   if ( 子_1_in >= 60 )
   {
     子_4_st = "强势" ;
     子_5_st = "||" ;
   }
   else
   {
     if ( 子_1_in >= 40 )
     {
       子_4_st = "中等" ;
       子_5_st = "|" ;
     }
     else
     {
       if ( 子_1_in >= 20 )
       {
         子_4_st = "偏弱" ;
         子_5_st = ":" ;
       }
       else
       {
         子_4_st = "弱势" ;
         子_5_st = "." ;
       }
     }
   }
 }
 子_6_st = (子_3_bo) ?"↗":"↘"  ;
 子_7_st = (子_3_bo) ?"多":"空"  ;
 子_8_st = "" ;
 if ( 子_3_bo )
 {
   for (子_9_in = 0 ; 子_9_in < 子_2_in ; 子_9_in ++)
   {
     if ( 子_9_in <  子_2_in - 1 )
     {
       子_8_st +="█";
     }
     else
     {
       子_8_st +="▓";
     }
   }
   for (子_10_in = 子_2_in ; 子_10_in < 10 ; 子_10_in ++)
   {
     子_8_st +="·";
   }
   子_8_st = 子_8_st + " " + 子_6_st + 子_5_st + " " + IntegerToString(子_1_in,0,32) + "% " + 子_7_st + "·" + 子_4_st ;
 }
 else
 {
   子_8_st = 子_7_st + "·" + 子_4_st + " " + IntegerToString(子_1_in,0,32) + "% " + 子_5_st + 子_6_st + " " ;
   for (子_11_in = 0 ; 子_11_in < 子_2_in ; 子_11_in ++)
   {
     if ( 子_11_in <  子_2_in - 1 )
     {
       子_8_st +="█";
     }
     else
     {
       子_8_st +="▓";
     }
   }
   for (子_12_in = 子_2_in ; 子_12_in < 10 ; 子_12_in ++)
   {
     子_8_st +="·";
   }
 }
 return(子_8_st);
 }
//lizong_16 <<==--------   --------
 uint lizong_17( int 木_0_in)
 {
  int       子_2_in;
  bool      子_3_bo;
//----- -----

 
 子_2_in=MathAbs(木_0_in);
 子_3_bo=木_0_in>0;
 
 if ( 总_161_bo_C6E )
 {
  
   if ( 子_2_in >= 70 )
   {
     return((子_3_bo) ?Red:DarkGreen ); 
   }
   if ( 子_2_in >= 40 )
   {
     return((子_3_bo) ?Crimson:ForestGreen ); 
   }
   return(DimGray); 
 }
 if ( 子_2_in >= 70 )
 {
   return((子_3_bo) ?DarkGreen:Red ); 
 }
 if ( 子_2_in >= 40 )
 {
   return((子_3_bo) ?ForestGreen:OrangeRed ); 
 }
 return(DimGray); 
 }
//lizong_17 <<==--------   --------
 void lizong_18( string 木_0_st,double 木_1_do,uint 木_2_ui,int 木_3_in,int 木_4_in,bool 木_5_bo)
 {
  datetime  子_1_da;
  datetime  子_2_da;
  datetime  子_3_da;
  int       子_4_in;
  int       子_5_in;
  int       子_6_in;
//----- -----

 if ( 木_5_bo )
 {
  
   子_1_da = iTime(NULL,0,0) ;
   
   子_2_da = 0 ;
   子_3_da = 0 ;
  
   子_4_in = (int)ChartGetInteger(0,100,0);
   if ( 子_4_in <= 0 )
   {
     子_4_in = 100 ;
   }
   
   子_5_in = (int)(子_4_in * 总_203_do_D78 / 100.0);
   
   子_6_in = (int)(子_4_in * 总_204_do_D80 / 100.0);
   
   if ( 子_5_in <  2 )
   {
     子_5_in = 2 ;
   }
   if ( 子_6_in <  5 )
   {
     子_6_in = 5 ;
   }
   子_2_da=子_1_da + PeriodSeconds(0) * 子_5_in;
   子_3_da=子_2_da + PeriodSeconds(0) * 子_6_in;
   if ( 子_2_da == 0 )
   {
     子_2_da=TimeCurrent() + PeriodSeconds(0) * 15;
   }
   if ( 子_3_da == 0 )
   {
     子_3_da=子_2_da + PeriodSeconds(0) * 50;
   }
   if ( ObjectFind(木_0_st) == -1 )
   {
     ObjectCreate(0,木_0_st,OBJ_TREND,0,子_2_da,木_1_do,子_3_da,木_1_do); 
     ObjectSetInteger(0,木_0_st,OBJPROP_COLOR,木_2_ui); 
     ObjectSetInteger(0,木_0_st,OBJPROP_STYLE,木_4_in); 
     ObjectSetInteger(0,木_0_st,OBJPROP_WIDTH,木_3_in); 
     ObjectSetInteger(0,木_0_st,OBJPROP_RAY_RIGHT,0); 
     ObjectSetInteger(0,木_0_st,OBJPROP_BACK,0x1); 
     ObjectSetInteger(0,木_0_st,OBJPROP_SELECTABLE,0); 
     return;
   }
   ObjectMove(0,木_0_st,0,子_2_da,木_1_do); 
   ObjectMove(0,木_0_st,1,子_3_da,木_1_do); 
   ObjectSetInteger(0,木_0_st,OBJPROP_COLOR,木_2_ui); 
   ObjectSetInteger(0,木_0_st,OBJPROP_STYLE,木_4_in); 
   ObjectSetInteger(0,木_0_st,OBJPROP_WIDTH,木_3_in); 
   ObjectSetInteger(0,木_0_st,OBJPROP_RAY_RIGHT,0); 
   return;
 }
 if ( ObjectFind(木_0_st) == -1 )   return;
 ObjectDelete(0,木_0_st); 
 }
//lizong_18 <<==--------   --------
 uint lizong_19( int 木_0_in,uint 木_1_ui)
 {
  bool      子_2_bo;
  bool      子_3_bo;
  bool      子_4_bo;
  bool      子_5_bo;
  bool      子_6_bo;
  bool      子_7_bo;
  bool      子_8_bo;
//----- -----
 int        临_in_1;
 int        临_in_2;
 int        临_in_3;
 int        临_in_4;
 int        临_in_5;
 int        临_in_6;
 int        临_in_7;
 int        临_in_8;
 int        临_in_9;
 int        临_in_10;
 int        临_in_11;
 int        临_in_12;

 if ( !(总_221_bo_DD6) )
 {
   return(木_1_ui); 
 }
 子_2_bo=总_23_do_420_ko[0]!=INT_MAX;
 子_3_bo=总_24_do_454_ko[0]!=INT_MAX;
 子_4_bo=总_25_do_488_ko[0]!=INT_MAX;
 子_5_bo=总_26_do_4BC_ko[0]!=INT_MAX;
 子_6_bo = 木_0_in>=4 && 木_0_in<=6 ;
 子_7_bo = 木_0_in>=1 && 木_0_in<=3 ;
 子_8_bo = 木_0_in==0 ;
 if ( 子_8_bo )
 {
   return(木_1_ui); 
 }
 if ( 子_2_bo )
 {
   if ( 子_6_bo )
   {
     return(木_1_ui); 
   }
   if ( 子_7_bo )
   {
     临_in_1=(int)((木_1_ui >> 16) & Red);
     临_in_2=(int)((木_1_ui >> 8) & Red);
     临_in_3=(int)(木_1_ui & Red);
     临_in_1 = int((临_in_1) * ((100.0 - 40) / 100.0));
     临_in_2 = int((临_in_2) * ((100.0 - 40) / 100.0));
     临_in_3 = int((临_in_3) * ((100.0 - 40) / 100.0));
     临_in_1 = MathMax(MathMin(临_in_1,255),0);
     临_in_2 = MathMax(MathMin(临_in_2,255),0);
     临_in_3 = MathMax(MathMin(临_in_3,255),0);
     return((临_in_1 << 16) | (临_in_2 << 8) | 临_in_3); 
   }
 }
 else
 {
   if ( 子_3_bo )
   {
     if ( 子_7_bo )
     {
       return(木_1_ui); 
     }
     if ( 子_6_bo )
     {
       临_in_4=(int)((木_1_ui >> 16) & Red);
       临_in_5=(int)((木_1_ui >> 8) & Red);
       临_in_6=(int)(木_1_ui & Red);
       临_in_4 = int((临_in_4) * ((100.0 - 40) / 100.0));
       临_in_5 = int((临_in_5) * ((100.0 - 40) / 100.0));
       临_in_6 = int((临_in_6) * ((100.0 - 40) / 100.0));
       临_in_4 = MathMax(MathMin(临_in_4,255),0);
       临_in_5 = MathMax(MathMin(临_in_5,255),0);
       临_in_6 = MathMax(MathMin(临_in_6,255),0);
       return((临_in_4 << 16) | (临_in_5 << 8) | 临_in_6); 
     }
   }
   else
   {
     if ( 子_4_bo )
     {
       临_in_7=(int)((木_1_ui >> 16) & Red);
       临_in_8=(int)((木_1_ui >> 8) & Red);
       临_in_9=(int)(木_1_ui & Red);
       临_in_7 = int((临_in_7) + (255 - (临_in_7)) * (15 / 100.0));
       临_in_8 = int((临_in_8) + (255 - (临_in_8)) * (15 / 100.0));
       临_in_9 = int((临_in_9) + (255 - (临_in_9)) * (15 / 100.0));
       临_in_7 = MathMax(MathMin(临_in_7,255),0);
       临_in_8 = MathMax(MathMin(临_in_8,255),0);
       临_in_9 = MathMax(MathMin(临_in_9,255),0);
       return((临_in_7 << 16) | (临_in_8 << 8) | 临_in_9); 
     }
     if ( 子_5_bo )
     {
       临_in_10=(int)((木_1_ui >> 16) & Red);
       临_in_11=(int)((木_1_ui >> 8) & Red);
       临_in_12=(int)(木_1_ui & Red);
       临_in_10 = int((临_in_10) * ((100.0 - 50) / 100.0));
       临_in_11 = int((临_in_11) * ((100.0 - 50) / 100.0));
       临_in_12 = int((临_in_12) * ((100.0 - 50) / 100.0));
       临_in_10 = MathMax(MathMin(临_in_10,255),0);
       临_in_11 = MathMax(MathMin(临_in_11,255),0);
       临_in_12 = MathMax(MathMin(临_in_12,255),0);
       return((临_in_10 << 16) | (临_in_11 << 8) | 临_in_12); 
     }
   }
 }
 return(木_1_ui); 
 }
//lizong_19 <<==--------   --------
 void lizong_20( double 木_0_do,double 木_1_do)
 {
  double    子_1_do;
  double    子_2_do;
  double    子_3_do;
  int       子_4_in;
  double    子_5_do;
  int       子_6_in;
  int       子_7_in;
  int       子_8_in;
  int       子_9_in;
  int       子_10_in;
  int       子_11_in;
  int       子_12_in;
  int       子_13_in;
  int       子_14_in;
//----- -----

 总_261_in_11D0 = 0 ;
 ArrayInitialize(总_262_in_1208_si7,0); 
 子_1_do = 木_1_do * 总_197_do_D50 ;
 子_2_do = 木_1_do * 总_198_do_D58 ;
 子_3_do = 木_1_do * 总_199_do_D60 ;
 for (子_4_in = 0 ; 子_4_in < 7 ; 子_4_in ++)
 {
   子_5_do=MathAbs(木_0_do - 总_254_do_F94_si7[子_4_in]);
   if ( 子_5_do<=子_1_do )
   {
     总_262_in_1208_si7[子_4_in] = 1;
     总_260_in_119C_ko[总_261_in_11D0] = 子_4_in;
     总_261_in_11D0 ++;
      continue;
   }
   if ( 子_5_do<=子_2_do && 总_196_in_D4C >= 2 )
   {
     总_262_in_1208_si7[子_4_in] = 2;
     总_260_in_119C_ko[总_261_in_11D0] = 子_4_in;
     总_261_in_11D0 ++;
      continue;
   }
   if ( 子_5_do<=子_3_do && 总_196_in_D4C >= 3 )
   {
     总_262_in_1208_si7[子_4_in] = 3;
     总_260_in_119C_ko[总_261_in_11D0] = 子_4_in;
     总_261_in_11D0 ++;
      continue;
   }
   总_262_in_1208_si7[子_4_in] = 0;
   
 }
 子_6_in = 1 ;
 子_7_in = 2 ;
 子_8_in = 3 ;
 子_9_in = 0 ;
 子_10_in = 0 ;
 子_11_in = 0 ;
 for (子_12_in = 0 ; 子_12_in < 总_261_in_11D0 ; 子_12_in ++)
 {
   子_13_in = 总_260_in_119C_ko[子_12_in] ;
   子_14_in = 总_262_in_1208_si7[子_13_in] ;
   if ( 子_14_in == 1 )
   {
     子_9_in ++;
     if ( 子_9_in <= 子_6_in )   continue;
     总_262_in_1208_si7[子_13_in] = 0;
      continue;
   }
   if ( 子_14_in == 2 )
   {
     子_10_in ++;
     if ( 子_10_in <= 子_7_in )   continue;
     总_262_in_1208_si7[子_13_in] = 0;
      continue;
   }
   if ( 子_14_in != 3 )   continue;
   子_11_in ++;
   if ( 子_11_in <= 子_8_in )   continue;
   总_262_in_1208_si7[子_13_in] = 0;
   
 }
 }
//lizong_20 <<==--------   --------
 void lizong_21()
 {
  int       子_1_in;
  string    子_2_st;
  double    子_3_do;
  double    子_4_do;
  double    子_5_do;
  double    子_6_do;
  double    子_7_do;
  double    子_8_do;
  datetime  子_9_da;
  double    子_10_do;
  int       子_11_in;
  double    子_12_do;
  bool      子_13_bo;
  int       子_14_in;
  double    子_15_do;
  bool      子_16_bo;
  bool      子_17_bo;
  bool      子_18_bo;
  bool      子_19_bo;
  int       子_20_in;
  string    子_21_st;
  int       子_22_in;
  double    子_23_do;
  int       子_24_in;
  int       子_25_in;
  double    子_26_do;
  int       子_27_in;
  int       子_28_in;
  uint      子_29_ui;
  string    子_30_st;
  string    子_31_st;
  string    子_32_st;
  string    子_33_st;
  double    子_34_do;
  string    子_35_st;
  string    子_36_st;
  string    子_37_st;
  string    子_38_st;
//----- -----
 double     临_do_1;
 bool       临_bo_2;
 int        临_in_3;
 double     临_do_4;
 double     临_do_5;
 string     临_st_6;
 int        临_in_7;
 string     临_st_8;

 if ( !(总_182_bo_CF4) )
 {
   for (子_1_in = 0 ; 子_1_in < 7 ; 子_1_in ++)
   {
     lizong_18(总_255_st_1000_si7[子_1_in],0.0,0xFFFFFFFF,1,2,false); 
     子_2_st=总_255_st_1000_si7[子_1_in] + "_Label";
     if ( ObjectFind(子_2_st) != -1 )
     {
       ObjectDelete(子_2_st); 
     }
   }
   总_263_in_1224 = -1 ;
   总_261_in_11D0 = 0 ;
   return;
 }
 子_3_do = iATR(Symbol(),0,总_183_in_CF8,0) ;
 if ( 子_3_do<=0.0 )   return;
 
 if ( !(总_219_bo_DD4) )
 {
   临_do_1 = iMA(Symbol(),0,总_82_in_AEC,0,1,0,0);
 }
 else
 {
   临_bo_2 = 总_28_do_524_ko[0]!=INT_MAX;
   临_in_3 = 总_82_in_AEC;
   if ( ( ( 总_23_do_420_ko[0]!=INT_MAX && 总_27_do_4F0_ko[0]!=INT_MAX ) || (总_24_do_454_ko[0]!=INT_MAX && 临_bo_2) ) )
   {
     临_in_3 = 总_84_in_AF4;
   }
   else
   {
     if ( ( 总_25_do_488_ko[0]!=INT_MAX || 总_27_do_4F0_ko[0]!=INT_MAX || 临_bo_2 ) )
     {
       临_in_3 = 52;
     }
     else
     {
       临_in_3 = 总_82_in_AEC;
     }
   }
   总_273_do_14C0 = 临_in_3 ;
   临_do_1 = iMA(Symbol(),0,临_in_3,0,1,0,0);
 }
 子_4_do = 临_do_1 ;
 if ( 子_4_do<=0.0 )   return;
 子_5_do = 子_3_do * 总_184_do_D00 ;
 总_254_do_F94_si7[0] = 子_4_do;
 总_254_do_F94_si7[1] = 子_4_do + 子_5_do;
 临_do_4 = 子_5_do * 2.0;
 总_254_do_F94_si7[2] = 子_4_do + 临_do_4;
 临_do_5 = 子_5_do * 3.0;
 总_254_do_F94_si7[3] = 子_4_do + 临_do_5;
 总_254_do_F94_si7[4] = 子_4_do - 子_5_do;
 总_254_do_F94_si7[5] = 子_4_do - 临_do_4;
 总_254_do_F94_si7[6] = 子_4_do - 临_do_5;
 子_6_do = iClose(Symbol(),0,0) ;
 子_7_do = iHigh(Symbol(),0,0) ;
 子_8_do = iLow(Symbol(),0,0) ;
 子_9_da = iTime(Symbol(),0,0) ;
 if ( ( 子_6_do<=0.000001 || 子_7_do<=0.000001 || 子_8_do<=0.000001 || 子_7_do<子_8_do || 子_9_da == 0 || 子_4_do<=0.000001 ) )
 {
   Print("警告: SR系统数据无效 - Price:",子_6_do," High:",子_7_do," Low:",子_8_do," Base:",子_4_do); 
   return;
 }
 子_10_do = 子_3_do * 0.1 ;
 for (子_11_in = 0 ; 子_11_in < 7 ; 子_11_in ++)
 {
   子_12_do = 总_254_do_F94_si7[子_11_in] ;
   子_13_bo = 子_7_do>=子_12_do - 子_10_do && 子_8_do<=子_12_do + 子_10_do ;
   if ( 子_13_bo && 总_258_da_1128_si7[子_11_in] != 子_9_da )
   {
     总_257_in_10D8_si7[子_11_in] ++;
     总_258_da_1128_si7[子_11_in] = 子_9_da;
   }
   if ( !(总_220_bo_DD5) )   continue;
   子_14_in = iBars(Symbol(),0) ;
   if ( 子_14_in <= 1 )   continue;
   子_15_do = iClose(Symbol(),0,1) ;
   子_16_bo=子_15_do<子_12_do - 子_10_do;
   子_17_bo=子_15_do>子_12_do + 子_10_do;
   子_18_bo=子_6_do>子_12_do + 子_10_do;
   子_19_bo=子_6_do<子_12_do - 子_10_do;
   if ( 子_16_bo && 子_18_bo )
   {
     总_259_bo_1194_si7[子_11_in] = true;
     总_269_in_1410_si7[子_11_in] = 1;
     总_268_da_13A4_si7[子_11_in] = 子_9_da;
      continue;
   }
   if ( 子_17_bo && 子_19_bo )
   {
     总_259_bo_1194_si7[子_11_in] = true;
     总_269_in_1410_si7[子_11_in] = -1;
     总_268_da_13A4_si7[子_11_in] = 子_9_da;
      continue;
   }
   if ( 子_18_bo || 子_19_bo )   continue;
   总_259_bo_1194_si7[子_11_in] = false;
   总_269_in_1410_si7[子_11_in] = 0;
   
 }
 lizong_20(子_6_do,子_3_do); 
 for (子_20_in = 0 ; 子_20_in < 7 ; 子_20_in ++)
 {
   if ( 总_262_in_1208_si7[子_20_in] != 0 )   continue;
   lizong_18(总_255_st_1000_si7[子_20_in],0.0,0xFFFFFFFF,1,2,false); 
   子_21_st=总_255_st_1000_si7[子_20_in] + "_Label";
   if ( ObjectFind(子_21_st) != -1 )
   {
     ObjectDelete(子_21_st); 
   }
   
 }
 子_22_in = -1 ;
 子_23_do = DBL_MAX ;
 for (子_24_in = 0 ; 子_24_in < 7 ; 子_24_in ++)
 {
   子_25_in = 总_262_in_1208_si7[子_24_in] ;
   if ( 子_25_in == 0 )   continue;
   子_26_do=MathAbs(子_6_do - 总_254_do_F94_si7[子_24_in]);
   if ( 子_26_do<子_23_do )
   {
     子_23_do = 子_26_do ;
     子_22_in = 子_24_in ;
   }
   子_27_in = 总_200_in_D68 ;
   子_28_in = 3 ;
   子_29_ui = 总_256_co_1088_si7[子_24_in] ;
   if ( 子_25_in == 1 )
   {
     子_27_in = 总_200_in_D68 ;
     子_28_in = 3 ;
   }
   else
   {
     if ( 子_25_in == 2 )
     {
       子_27_in = 总_201_in_D6C ;
       子_28_in = 1 ;
     }
     else
     {
       if ( 子_25_in == 3 )
       {
         子_27_in = 总_202_in_D70 ;
         子_28_in = 2 ;
       }
     }
   }
   if ( 总_259_bo_1194_si7[子_24_in] && 总_209_bo_D97 )
   {
     子_29_ui = 总_194_ui_D38 ;
   }
   else
   {
     子_29_ui = lizong_19(子_24_in,子_29_ui) ;
   }
   lizong_18(总_255_st_1000_si7[子_24_in],总_254_do_F94_si7[子_24_in],子_29_ui,子_27_in,子_28_in,true); 
   if ( 子_25_in != 1 )   continue;
   
   if ( ( 子_24_in < 0 || 子_24_in >= 7 ) )
   {
     临_st_6 = "未知";
   }
   else
   {
     if ( 子_24_in == 0 )
     {
       临_st_6 = "中心线";
     }
     else
     {
       if ( 子_24_in >= 1 && 子_24_in <= 3 )
       {
         临_st_6 = "阻力" + IntegerToString(子_24_in,0,32);
       }
       else
       {
         临_st_6 = "支撑" + IntegerToString(子_24_in - 3,0,32);
       }
     }
   }
   子_30_st = 临_st_6 ;
   子_31_st = lizong_23(子_24_in) ;
   子_32_st = "" ;
   子_33_st = "" ;
   if ( 总_206_bo_D94 )
   {
     子_34_do = 子_26_do / Point ;
     子_35_st = (子_6_do>总_254_do_F94_si7[子_24_in]) ?"^":"v"  ;
     子_32_st = " [" + (子_35_st) + DoubleToString(子_34_do,1) + "点]" ;
   }
   子_36_st = "" ;
   if ( 总_207_bo_D95 && 总_257_in_10D8_si7[子_24_in] >  0 )
   {
     临_in_7 = 总_257_in_10D8_si7[子_24_in];
     
     临_st_8 = "";
     if ( 临_in_7 >= 10 )
     {
       临_st_8 = " ★★★";
     }
     else
     {
       if ( 临_in_7 >= 7 )
       {
         临_st_8 = " ★★";
       }
       else
       {
         if ( 临_in_7 >= 4 )
         {
           临_st_8 = " ★";
         }
         else
         {
           if ( 临_in_7 >= 1 )
           {
             临_st_8 = " ☆";
           }
         }
       }
     }
     子_37_st = 临_st_8 ;
     子_36_st = " 触" + IntegerToString(总_257_in_10D8_si7[子_24_in],0,32) + 子_37_st ;
   }
   if ( 总_209_bo_D97 && 总_259_bo_1194_si7[子_24_in] )
   {
     子_33_st = " [突破!]" ;
   }
   子_38_st = "" ;
   if ( 总_212_bo_DA8 )
   {
     子_38_st=子_30_st + 子_31_st;
   }
   else
   {
     子_38_st = 子_30_st + 子_31_st + 子_32_st + 子_36_st + 子_33_st ;
   }
   lizong_24(总_255_st_1000_si7[子_24_in],总_254_do_F94_si7[子_24_in],子_38_st,子_29_ui,子_24_in); 
   
 }
 总_263_in_1224 = 子_22_in ;
 if ( !(总_214_bo_DBC) )   return;
 lizong_22(子_6_do,子_3_do); 
 }
//lizong_21 <<==--------   --------
 void lizong_22( double 木_0_do,double 木_1_do)
 {
  datetime  子_1_da;
  int       子_2_in;
  double    子_3_do;
  double    子_4_do;
  int       子_5_in;
  int       子_6_in;
  datetime  子_7_da;
  string    子_8_st;
  string    子_9_st;
  double    子_10_do;
  string    子_11_st;
//----- -----
 string     临_st_1;

 子_1_da = TimeCurrent() ;
 for (子_2_in = 0 ; 子_2_in < 7 ; 子_2_in ++)
 {
   if ( 总_262_in_1208_si7[子_2_in] == 0 )   continue;
   子_3_do = 总_254_do_F94_si7[子_2_in] ;
   子_4_do=MathAbs(木_0_do - 子_3_do);
   子_5_in = 0 ;
   if ( 子_4_do<=木_1_do * 0.2 )
   {
     子_5_in = 3 ;
   }
   else
   {
     if ( 子_4_do<=木_1_do * 0.5 )
     {
       子_5_in = 2 ;
     }
     else
     {
       if ( 子_4_do<=木_1_do )
       {
         子_5_in = 1 ;
       }
     }
   }
   if ( 子_5_in >  0 && 子_5_in <  总_215_in_DC0 )
   {
     子_5_in = 0 ;
   }
   子_6_in = 总_264_in_125C_si7[子_2_in] ;
   总_264_in_125C_si7[子_2_in] = 子_5_in;
   if ( 子_5_in >  子_6_in && 子_5_in >= 2 )
   {
     子_7_da = iTime(NULL,0,0) ;
     if ( 总_265_da_12AC_si7[子_2_in] != 子_7_da )
     {
       总_265_da_12AC_si7[子_2_in] = 子_7_da;
       if ( ( 子_2_in < 0 || 子_2_in >= 7 ) )
       {
         临_st_1 = "未知";
       }
       else
       {
         if ( 子_2_in == 0 )
         {
           临_st_1 = "中心线";
         }
         else
         {
           if ( 子_2_in >= 1 && 子_2_in <= 3 )
           {
             临_st_1 = "阻力" + IntegerToString(子_2_in,0,32);
           }
           else
           {
             临_st_1 = "支撑" + IntegerToString(子_2_in - 3,0,32);
           }
         }
       }
       子_8_st = 临_st_1 ;
       子_9_st = lizong_23(子_2_in) ;
       子_10_do = 子_4_do / Point ;
       子_11_st = "" ;
       if ( 子_5_in == 3 )
       {
         子_11_st = StringFormat("【SR三级预警】正在触碰 %s%s！\n距离: %.1f点",子_8_st,子_9_st,子_10_do) ;
       }
       else
       {
         if ( 子_5_in == 2 )
         {
           子_11_st = StringFormat("【SR二级预警】即将触碰 %s%s！\n距离: %.1f点",子_8_st,子_9_st,子_10_do) ;
         }
       }
       if ( 总_216_bo_DC4 && 子_11_st != "" )
       {
         Alert(子_11_st); 
       }
       else
       {
         if ( 子_11_st != "" )
         {
           Print(子_11_st); 
         }
       }
     }
   }
   if ( 总_217_bo_DC5 && 子_5_in >= 2 )
   {
     总_267_in_1354_si7[子_2_in] ++;
     总_266_bo_1318_si7[子_2_in] = 总_267_in_1354_si7[子_2_in] % 2==0;
      continue;
   }
   总_267_in_1354_si7[子_2_in] = 0;
   总_266_bo_1318_si7[子_2_in] = false;
   
 }
 }
//lizong_22 <<==--------   --------
 string lizong_23( int 木_0_in)
 {
  int       子_1_in;
//----- -----

 if ( ( 木_0_in < 0 || 木_0_in >= 7 ) )
 {
   return("");
 }
 if ( !(总_208_bo_D96) )
 {
   return("");
 }
 子_1_in = 总_257_in_10D8_si7[木_0_in] ;
 if ( 子_1_in >= 10 )
 {
   return(" (***极强)");
 }
 if ( 子_1_in >= 6 )
 {
   return(" (**强)");
 }
 if ( 子_1_in >= 3 )
 {
   return(" (*中)");
 }
 if ( 子_1_in >= 1 )
 {
   return(" (弱)");
 }
 return("");
 }
//lizong_23 <<==--------   --------
 void lizong_24( string 木_0_st,double 木_1_do,string 木_2_st,uint 木_3_ui,int 木_4_in)
 {
  string    子_1_st;
  int       子_2_in;
  int       子_3_in;
  datetime  子_4_da;
  double    子_5_do;
  double    子_6_do;
  int       子_7_in;
//----- -----

 子_1_st=木_0_st + "_Label";
 子_2_in=(int)ChartGetInteger(0,100,0);
 if ( 子_2_in <= 0 )
 {
   子_2_in = 100 ;
 }
 子_3_in=(int)(子_2_in * 总_211_do_DA0 / 100.0);
 if ( 子_3_in <  1 )
 {
   子_3_in = 1 ;
 }
 子_4_da=iTime(NULL,0,0) + PeriodSeconds(0) * 子_3_in;
 子_5_do = iATR(Symbol(),0,总_183_in_CF8,0) ;
 if ( 子_5_do<=0.0 )
 {
   子_5_do = Point * 100.0 ;
 }
 子_6_do = 木_1_do ;
 子_7_in = 1 ;
 if ( 木_4_in == 0 )
 {
   子_6_do = 木_1_do - 子_5_do * 0.01 ;
   子_7_in = 0 ;
 }
 else
 {
   if ( 木_4_in >= 1 && 木_4_in <= 3 )
   {
     子_6_do = 子_5_do * 0.01 + 木_1_do ;
     子_7_in = 2 ;
   }
   else
   {
     if ( 木_4_in >= 4 && 木_4_in <= 6 )
     {
       子_6_do = 木_1_do - 子_5_do * 0.01 ;
       子_7_in = 0 ;
     }
   }
 }
 if ( ObjectFind(子_1_st) == -1 )
 {
   ObjectCreate(0,子_1_st,OBJ_TEXT,0,子_4_da,子_6_do); 
   ObjectSetString(0,子_1_st,OBJPROP_FONT,总_68_st_A88); 
   ObjectSetInteger(0,子_1_st,OBJPROP_FONTSIZE,总_210_in_D98); 
   ObjectSetInteger(0,子_1_st,OBJPROP_ANCHOR,子_7_in); 
   ObjectSetInteger(0,子_1_st,OBJPROP_SELECTABLE,0); 
 }
 else
 {
   ObjectSetInteger(0,子_1_st,OBJPROP_ANCHOR,子_7_in); 
   ObjectSetInteger(0,子_1_st,OBJPROP_FONTSIZE,总_210_in_D98); 
 }
 ObjectSetString(0,子_1_st,OBJPROP_TEXT," " + 木_2_st); 
 ObjectSetInteger(0,子_1_st,OBJPROP_COLOR,木_3_ui); 
 ObjectMove(0,子_1_st,0,子_4_da,子_6_do); 
 }
//lizong_24 <<==--------   --------
 void lizong_25()
 {
  string    子_1_st;
  int       子_2_in;
  string    子_3_st;
  int       子_4_in;
  int       子_5_in;
//----- -----

 子_1_st = CurrencyPairs ;
 ArrayResize(总_275_st_14CC_ko,0,0); 
 总_276_in_1500 = 0 ;
 while (StringLen(子_1_st)  > 0)
 {
   子_2_in = StringFind(子_1_st,",",0) ;
   子_3_st = "" ;
   if ( 子_2_in >= 0 )
   {
     if ( 子_2_in >  0 )
     {
       子_3_st = StringSubstr(子_1_st,0,子_2_in) ;
     }
     if ( 子_2_in + 1 <  StringLen(子_1_st)  )
     {
       子_1_st = StringSubstr(子_1_st,子_2_in + 1,0) ;
     }
     else
     {
       子_1_st = "" ;
     }
   }
   else
   {
     子_3_st = 子_1_st ;
     子_1_st = "" ;
   }
   StringTrimLeft(子_3_st); 
   StringTrimRight(子_3_st); 
   if ( StringLen(子_3_st)  >= 3 )
   {
     ArrayResize(总_275_st_14CC_ko,总_276_in_1500 + 1,0); 
     总_275_st_14CC_ko[总_276_in_1500] = 子_3_st;
     总_276_in_1500 ++;
   }
 }
 ArrayResize(总_277_in_1504_ko,总_276_in_1500 * 5,0); 
 for (子_4_in = 0 ; 子_4_in < 总_276_in_1500 * 5 ; 子_4_in ++)
 {
   总_277_in_1504_ko[子_4_in] = 50;
 }
 ArrayResize(总_280_in_1548_ko,总_276_in_1500,0); 
 ArrayResize(总_281_da_157C_ko,总_276_in_1500,0); 
 for (子_5_in = 0 ; 子_5_in < 总_276_in_1500 ; 子_5_in ++)
 {
   总_280_in_1548_ko[子_5_in] = 0;
   总_281_da_157C_ko[子_5_in] = 0;
 }
 }
//lizong_25 <<==--------   --------
 void lizong_26()
 {
  string    子_1_st;
  int       子_2_in;
  int       子_3_in;
  int       子_4_in;
  int       子_5_in;
//----- -----
 string     临_st_1;

 子_1_st = "ToggleBtn_Monitor" ;
 if ( ObjectFind(子_1_st) != -1 )
 {
   ObjectDelete(子_1_st); 
 }
 子_2_in = 560 ;
 子_3_in = 0 ;
 子_4_in = 120 ;
 子_5_in = 25 ;
 ObjectCreate(0,子_1_st,OBJ_BUTTON,0,0,0.0); 
 ObjectSetInteger(0,子_1_st,OBJPROP_XDISTANCE,0x230); 
 ObjectSetInteger(0,子_1_st,OBJPROP_YDISTANCE,0); 
 ObjectSetInteger(0,子_1_st,OBJPROP_XSIZE,0x78); 
 ObjectSetInteger(0,子_1_st,OBJPROP_YSIZE,0x19); 
 ObjectSetInteger(0,子_1_st,OBJPROP_CORNER,0); 
 ObjectSetInteger(0,子_1_st,OBJPROP_FONTSIZE,0x9); 
 ObjectSetString(0,子_1_st,OBJPROP_FONT,"Arial Bold"); 
 ObjectSetInteger(0,子_1_st,OBJPROP_BGCOLOR,(总_274_bo_14C8) ?DarkOrange:0x40342D ); 
 ObjectSetInteger(0,子_1_st,OBJPROP_COLOR,0xFFFFFF); 
 ObjectSetInteger(0,子_1_st,OBJPROP_BORDER_COLOR,0); 
 ObjectSetInteger(0,子_1_st,OBJPROP_BACK,0); 
 ObjectSetInteger(0,子_1_st,OBJPROP_STATE,0); 
 ObjectSetInteger(0,子_1_st,OBJPROP_SELECTABLE,0); 
 ObjectSetInteger(0,子_1_st,OBJPROP_SELECTED,0); 
 if ( 总_274_bo_14C8 )
 {
   临_st_1 = "货币监测 [ON]";
 }
 else
 {
   临_st_1 = "货币监测 [OFF]";
 }
 ObjectSetString(0,子_1_st,OBJPROP_TEXT,临_st_1); 
 }
//lizong_26 <<==--------   --------
 int lizong_27( string 木_0_st,int 木_1_in)
 {
  double    子_2_do;
  double    子_3_do;
  double    子_4_do;
  double    子_5_do;
  double    子_6_do;
  double    子_7_do;
  int       子_8_in;
  double    子_9_do;
  double    子_10_do;
  double    子_11_do;
  double    子_12_do;
//----- -----
 double     临_do_1;
 double     临_do_2;
 double     临_do_3;

 if ( ( StringLen(木_0_st)  < 3 || 木_1_in <= 0 ) )
 {
   return(50); 
 }
 子_2_do = iMA(木_0_st,木_1_in,总_56_in_A54,0,1,0,0) ;
 子_3_do = iMA(木_0_st,木_1_in,总_57_in_A58,0,1,0,0) ;
 子_4_do = iMA(木_0_st,木_1_in,总_62_in_A6C,0,1,0,0) ;
 子_5_do = iMA(木_0_st,木_1_in,总_63_in_A70,0,1,0,0) ;
 子_6_do = iClose(木_0_st,木_1_in,0) ;
 子_7_do = iATR(木_0_st,木_1_in,总_85_in_AF8,0) ;
 if ( ( 子_2_do<=0.0 || 子_3_do<=0.0 || 子_4_do<=0.0 || 子_5_do<=0.0 || 子_6_do<=0.0 || 子_7_do<=0.000001 ) )
 {
   return(50); 
 }
 子_8_in = 50 ;
 子_9_do = (子_2_do - 子_3_do) / 子_7_do ;
 if ( MathAbs(子_9_do)<1000.0 )
 {
   if ( (MathAbs(子_9_do)) * 20.0 >= 20 )
   {
     临_do_1 = 20.0;
   }
   else
   {
     临_do_1 = (MathAbs(子_9_do)) * 20.0;
   }
   子_8_in +=int(临_do_1 * ((子_9_do>0.0) ?1:-1 ));
 }
 子_10_do = (子_4_do - 子_5_do) / 子_7_do ;
 if ( MathAbs(子_10_do)<1000.0 )
 {
   if ( (MathAbs(子_10_do)) * 20.0 >= 20 )
   {
     临_do_2 = 20.0;
   }
   else
   {
     临_do_2 = (MathAbs(子_10_do)) * 20.0;
   }
   子_8_in +=int(临_do_2 * ((子_10_do>0.0) ?1:-1 ));
 }
 子_11_do = (子_2_do + 子_3_do + 子_4_do + 子_5_do) / 4.0 ;
 if ( 子_11_do>0.0 )
 {
   子_12_do = (子_6_do - 子_11_do) / 子_7_do ;
   if ( MathAbs(子_12_do)<1000.0 )
   {
     if ( (MathAbs(子_12_do)) * 10.0 >= 10 )
     {
       临_do_3 = 10.0;
     }
     else
     {
       临_do_3 = (MathAbs(子_12_do)) * 10.0;
     }
     子_8_in +=int(临_do_3 * ((子_12_do>0.0) ?1:-1 ));
   }
 }
 return(MathMin(MathMax(子_8_in,0),100)); 
 }
//lizong_27 <<==--------   --------
 void lizong_28()
 {
  int       子_1_in;
  string    子_2_st;
  string    子_3_st;
  string    子_4_st;
  int       子_5_in;
  int       子_6_in;
  int       子_7_in;
  int       子_8_in;
  int       子_9_in;
  int       子_10_in;
  int       子_11_in;
  int       子_12_in;
  int       子_13_in;
  int       子_14_in;
  int       子_15_in;
  int       子_16_in;
  int       子_17_in;
  int       子_18_in_si5[5];
  int       子_19_in;
  int       子_20_in;
  int       子_21_in;
  string    子_22_st;
  string    子_23_st;
  int       子_24_in;
  int       子_25_in;
  int       子_26_in;
  int       子_27_in;
  uint      子_28_ui;
  string    子_29_st;
  string    子_30_st;
  int       子_31_in;
  int       子_32_in;
  int       子_33_in;
  int       子_34_in;
  string    子_35_st;
  uint      子_36_ui;
  string    子_37_st;
//----- -----
 bool       临_bo_1;
 uint       临_ui_2;
 int        临_in_3;
 string     临_st_4;
 int        临_in_5;
 int        临_in_6;
 string     临_st_7;
 bool       临_bo_8;
 uint       临_ui_9;
 int        临_in_10;
 string     临_st_11;
 int        临_in_12;
 int        临_in_13;
 string     临_st_14;
 bool       临_bo_15;
 uint       临_ui_16;
 int        临_in_17;
 string     临_st_18;
 int        临_in_19;
 int        临_in_20;
 string     临_st_21;
 bool       临_bo_22;
 uint       临_ui_23;
 int        临_in_24;
 string     临_st_25;
 int        临_in_26;
 int        临_in_27;
 string     临_st_28;
 bool       临_bo_29;
 uint       临_ui_30;
 int        临_in_31;
 string     临_st_32;
 int        临_in_33;
 int        临_in_34;
 string     临_st_35;
 bool       临_bo_36;
 uint       临_ui_37;
 int        临_in_38;
 string     临_st_39;
 int        临_in_40;
 int        临_in_41;
 string     临_st_42;
 bool       临_bo_43;
 uint       临_ui_44;
 int        临_in_45;
 string     临_st_46;
 int        临_in_47;
 int        临_in_48;
 string     临_st_49;
 bool       临_bo_50;
 uint       临_ui_51;
 int        临_in_52;
 string     临_st_53;
 int        临_in_54;
 int        临_in_55;
 string     临_st_56;
 bool       临_bo_57;
 uint       临_ui_58;
 int        临_in_59;
 string     临_st_60;
 int        临_in_61;
 int        临_in_62;
 string     临_st_63;
 bool       临_bo_64;
 uint       临_ui_65;
 int        临_in_66;
 string     临_st_67;
 int        临_in_68;
 int        临_in_69;
 string     临_st_70;
 bool       临_bo_71;
 uint       临_ui_72;
 int        临_in_73;
 string     临_st_74;
 int        临_in_75;
 int        临_in_76;
 string     临_st_77;

 if ( !(总_274_bo_14C8) )
 {
   for (子_1_in=ObjectsTotal(-1) - 1 ; 子_1_in >= 0 ; 子_1_in --)
   {
     子_2_st = ObjectName(子_1_in) ;
     if ( StringFind(子_2_st,"Monitor_",0) == 0 )
     {
       ObjectDelete(子_2_st); 
     }
   }
   return;
 }
 子_3_st = "Monitor_Panel_BG" ;
 if ( ObjectFind(子_3_st) == -1 )
 {
   ObjectCreate(0,子_3_st,OBJ_RECTANGLE_LABEL,0,0,0.0); 
   ObjectSetInteger(0,子_3_st,OBJPROP_XDISTANCE,MonitorPanelX); 
   ObjectSetInteger(0,子_3_st,OBJPROP_YDISTANCE,MonitorPanelY); 
   ObjectSetInteger(0,子_3_st,OBJPROP_XSIZE,MonitorPanelWidth); 
   ObjectSetInteger(0,子_3_st,OBJPROP_YSIZE,MonitorPanelHeight); 
   ObjectSetInteger(0,子_3_st,OBJPROP_BGCOLOR,总_227_ui_DE8); 
   ObjectSetInteger(0,子_3_st,OBJPROP_BORDER_TYPE,0x1); 
   ObjectSetInteger(0,子_3_st,OBJPROP_CORNER,0); 
   ObjectSetInteger(0,子_3_st,OBJPROP_COLOR,0x808080); 
   ObjectSetInteger(0,子_3_st,OBJPROP_WIDTH,0x2); 
   ObjectSetInteger(0,子_3_st,OBJPROP_BACK,0); 
   ObjectSetInteger(0,子_3_st,OBJPROP_SELECTABLE,0); 
 }
 子_4_st = "Monitor_Title_BG" ;
 if ( ObjectFind(子_4_st) == -1 )
 {
   ObjectCreate(0,子_4_st,OBJ_RECTANGLE_LABEL,0,0,0.0); 
   ObjectSetInteger(0,子_4_st,OBJPROP_XDISTANCE,MonitorPanelX); 
   ObjectSetInteger(0,子_4_st,OBJPROP_YDISTANCE,MonitorPanelY); 
   ObjectSetInteger(0,子_4_st,OBJPROP_XSIZE,MonitorPanelWidth); 
   ObjectSetInteger(0,子_4_st,OBJPROP_YSIZE,0x16); 
   ObjectSetInteger(0,子_4_st,OBJPROP_BGCOLOR,总_228_ui_DEC); 
   ObjectSetInteger(0,子_4_st,OBJPROP_CORNER,0); 
   ObjectSetInteger(0,子_4_st,OBJPROP_BACK,0); 
   ObjectSetInteger(0,子_4_st,OBJPROP_SELECTABLE,0); 
 }
 临_bo_1 = true;
 临_ui_2 = White;
 临_in_3 = 总_226_in_DE4 + 1;
 临_st_4 = "  【多货币监测仪 - 红涨绿跌】";
 临_in_5 = MonitorPanelX + 100;
 临_in_6 = MonitorPanelY + 4;
 if ( ObjectFind("Monitor_Title") == -1 )
 {
   ObjectCreate(0,"Monitor_Title",OBJ_LABEL,0,0,0.0); 
   ObjectSetInteger(0,"Monitor_Title",OBJPROP_CORNER,0); 
   ObjectSetInteger(0,"Monitor_Title",OBJPROP_ANCHOR,0); 
   ObjectSetInteger(0,"Monitor_Title",OBJPROP_SELECTABLE,0); 
   ObjectSetInteger(0,"Monitor_Title",OBJPROP_BACK,0); 
 }
 ObjectSetInteger(0,"Monitor_Title",OBJPROP_XDISTANCE,临_in_5); 
 ObjectSetInteger(0,"Monitor_Title",OBJPROP_YDISTANCE,临_in_6); 
 ObjectSetString(0,"Monitor_Title",OBJPROP_TEXT,临_st_4); 
 if ( 临_bo_1 )
 {
   临_st_7 = "Arial Bold";
 }
 else
 {
   临_st_7 = "Arial";
 }
 ObjectSetString(0,"Monitor_Title",OBJPROP_FONT,临_st_7); 
 ObjectSetInteger(0,"Monitor_Title",OBJPROP_FONTSIZE,临_in_3); 
 ObjectSetInteger(0,"Monitor_Title",OBJPROP_COLOR,临_ui_2); 
 子_5_in = 28 ;
 子_6_in = 80 ;
 子_7_in = 50 ;
 子_8_in = 120 ;
 子_9_in = 10 ;
 子_10_in=10 + 80;
 子_11_in=子_10_in + 50;
 子_12_in=子_11_in + 50;
 子_13_in=子_12_in + 50;
 子_14_in=子_13_in + 50;
 子_15_in=子_14_in + 50;
 临_bo_8 = true;
 临_ui_9 = Yellow;
 临_in_10 = 总_226_in_DE4;
 临_st_11 = "货币对";
 临_in_12 = MonitorPanelX + 10;
 临_in_13 = MonitorPanelY + 28;
 if ( ObjectFind("Monitor_Header_Symbol") == -1 )
 {
   ObjectCreate(0,"Monitor_Header_Symbol",OBJ_LABEL,0,0,0.0); 
   ObjectSetInteger(0,"Monitor_Header_Symbol",OBJPROP_CORNER,0); 
   ObjectSetInteger(0,"Monitor_Header_Symbol",OBJPROP_ANCHOR,0); 
   ObjectSetInteger(0,"Monitor_Header_Symbol",OBJPROP_SELECTABLE,0); 
   ObjectSetInteger(0,"Monitor_Header_Symbol",OBJPROP_BACK,0); 
 }
 ObjectSetInteger(0,"Monitor_Header_Symbol",OBJPROP_XDISTANCE,临_in_12); 
 ObjectSetInteger(0,"Monitor_Header_Symbol",OBJPROP_YDISTANCE,临_in_13); 
 ObjectSetString(0,"Monitor_Header_Symbol",OBJPROP_TEXT,临_st_11); 
 if ( 临_bo_8 )
 {
   临_st_14 = "Arial Bold";
 }
 else
 {
   临_st_14 = "Arial";
 }
 ObjectSetString(0,"Monitor_Header_Symbol",OBJPROP_FONT,临_st_14); 
 ObjectSetInteger(0,"Monitor_Header_Symbol",OBJPROP_FONTSIZE,临_in_10); 
 ObjectSetInteger(0,"Monitor_Header_Symbol",OBJPROP_COLOR,临_ui_9); 
 临_bo_15 = true;
 临_ui_16 = Yellow;
 临_in_17 = 总_226_in_DE4;
 临_st_18 = "M1";
 临_in_19 = MonitorPanelX + (子_10_in + 15);
 临_in_20 = MonitorPanelY + 子_5_in;
 if ( ObjectFind("Monitor_Header_M1") == -1 )
 {
   ObjectCreate(0,"Monitor_Header_M1",OBJ_LABEL,0,0,0.0); 
   ObjectSetInteger(0,"Monitor_Header_M1",OBJPROP_CORNER,0); 
   ObjectSetInteger(0,"Monitor_Header_M1",OBJPROP_ANCHOR,0); 
   ObjectSetInteger(0,"Monitor_Header_M1",OBJPROP_SELECTABLE,0); 
   ObjectSetInteger(0,"Monitor_Header_M1",OBJPROP_BACK,0); 
 }
 ObjectSetInteger(0,"Monitor_Header_M1",OBJPROP_XDISTANCE,临_in_19); 
 ObjectSetInteger(0,"Monitor_Header_M1",OBJPROP_YDISTANCE,临_in_20); 
 ObjectSetString(0,"Monitor_Header_M1",OBJPROP_TEXT,临_st_18); 
 if ( 临_bo_15 )
 {
   临_st_21 = "Arial Bold";
 }
 else
 {
   临_st_21 = "Arial";
 }
 ObjectSetString(0,"Monitor_Header_M1",OBJPROP_FONT,临_st_21); 
 ObjectSetInteger(0,"Monitor_Header_M1",OBJPROP_FONTSIZE,临_in_17); 
 ObjectSetInteger(0,"Monitor_Header_M1",OBJPROP_COLOR,临_ui_16); 
 临_bo_22 = true;
 临_ui_23 = Yellow;
 临_in_24 = 总_226_in_DE4;
 临_st_25 = "M5";
 临_in_26 = MonitorPanelX + (子_11_in + 15);
 临_in_27 = MonitorPanelY + 子_5_in;
 if ( ObjectFind("Monitor_Header_M5") == -1 )
 {
   ObjectCreate(0,"Monitor_Header_M5",OBJ_LABEL,0,0,0.0); 
   ObjectSetInteger(0,"Monitor_Header_M5",OBJPROP_CORNER,0); 
   ObjectSetInteger(0,"Monitor_Header_M5",OBJPROP_ANCHOR,0); 
   ObjectSetInteger(0,"Monitor_Header_M5",OBJPROP_SELECTABLE,0); 
   ObjectSetInteger(0,"Monitor_Header_M5",OBJPROP_BACK,0); 
 }
 ObjectSetInteger(0,"Monitor_Header_M5",OBJPROP_XDISTANCE,临_in_26); 
 ObjectSetInteger(0,"Monitor_Header_M5",OBJPROP_YDISTANCE,临_in_27); 
 ObjectSetString(0,"Monitor_Header_M5",OBJPROP_TEXT,临_st_25); 
 if ( 临_bo_22 )
 {
   临_st_28 = "Arial Bold";
 }
 else
 {
   临_st_28 = "Arial";
 }
 ObjectSetString(0,"Monitor_Header_M5",OBJPROP_FONT,临_st_28); 
 ObjectSetInteger(0,"Monitor_Header_M5",OBJPROP_FONTSIZE,临_in_24); 
 ObjectSetInteger(0,"Monitor_Header_M5",OBJPROP_COLOR,临_ui_23); 
 临_bo_29 = true;
 临_ui_30 = Yellow;
 临_in_31 = 总_226_in_DE4;
 临_st_32 = "M15";
 临_in_33 = MonitorPanelX + (子_12_in + 12);
 临_in_34 = MonitorPanelY + 子_5_in;
 if ( ObjectFind("Monitor_Header_M15") == -1 )
 {
   ObjectCreate(0,"Monitor_Header_M15",OBJ_LABEL,0,0,0.0); 
   ObjectSetInteger(0,"Monitor_Header_M15",OBJPROP_CORNER,0); 
   ObjectSetInteger(0,"Monitor_Header_M15",OBJPROP_ANCHOR,0); 
   ObjectSetInteger(0,"Monitor_Header_M15",OBJPROP_SELECTABLE,0); 
   ObjectSetInteger(0,"Monitor_Header_M15",OBJPROP_BACK,0); 
 }
 ObjectSetInteger(0,"Monitor_Header_M15",OBJPROP_XDISTANCE,临_in_33); 
 ObjectSetInteger(0,"Monitor_Header_M15",OBJPROP_YDISTANCE,临_in_34); 
 ObjectSetString(0,"Monitor_Header_M15",OBJPROP_TEXT,临_st_32); 
 if ( 临_bo_29 )
 {
   临_st_35 = "Arial Bold";
 }
 else
 {
   临_st_35 = "Arial";
 }
 ObjectSetString(0,"Monitor_Header_M15",OBJPROP_FONT,临_st_35); 
 ObjectSetInteger(0,"Monitor_Header_M15",OBJPROP_FONTSIZE,临_in_31); 
 ObjectSetInteger(0,"Monitor_Header_M15",OBJPROP_COLOR,临_ui_30); 
 临_bo_36 = true;
 临_ui_37 = Yellow;
 临_in_38 = 总_226_in_DE4;
 临_st_39 = "H1";
 临_in_40 = MonitorPanelX + (子_13_in + 15);
 临_in_41 = MonitorPanelY + 子_5_in;
 if ( ObjectFind("Monitor_Header_H1") == -1 )
 {
   ObjectCreate(0,"Monitor_Header_H1",OBJ_LABEL,0,0,0.0); 
   ObjectSetInteger(0,"Monitor_Header_H1",OBJPROP_CORNER,0); 
   ObjectSetInteger(0,"Monitor_Header_H1",OBJPROP_ANCHOR,0); 
   ObjectSetInteger(0,"Monitor_Header_H1",OBJPROP_SELECTABLE,0); 
   ObjectSetInteger(0,"Monitor_Header_H1",OBJPROP_BACK,0); 
 }
 ObjectSetInteger(0,"Monitor_Header_H1",OBJPROP_XDISTANCE,临_in_40); 
 ObjectSetInteger(0,"Monitor_Header_H1",OBJPROP_YDISTANCE,临_in_41); 
 ObjectSetString(0,"Monitor_Header_H1",OBJPROP_TEXT,临_st_39); 
 if ( 临_bo_36 )
 {
   临_st_42 = "Arial Bold";
 }
 else
 {
   临_st_42 = "Arial";
 }
 ObjectSetString(0,"Monitor_Header_H1",OBJPROP_FONT,临_st_42); 
 ObjectSetInteger(0,"Monitor_Header_H1",OBJPROP_FONTSIZE,临_in_38); 
 ObjectSetInteger(0,"Monitor_Header_H1",OBJPROP_COLOR,临_ui_37); 
 临_bo_43 = true;
 临_ui_44 = Yellow;
 临_in_45 = 总_226_in_DE4;
 临_st_46 = "H4";
 临_in_47 = MonitorPanelX + (子_14_in + 15);
 临_in_48 = MonitorPanelY + 子_5_in;
 if ( ObjectFind("Monitor_Header_H4") == -1 )
 {
   ObjectCreate(0,"Monitor_Header_H4",OBJ_LABEL,0,0,0.0); 
   ObjectSetInteger(0,"Monitor_Header_H4",OBJPROP_CORNER,0); 
   ObjectSetInteger(0,"Monitor_Header_H4",OBJPROP_ANCHOR,0); 
   ObjectSetInteger(0,"Monitor_Header_H4",OBJPROP_SELECTABLE,0); 
   ObjectSetInteger(0,"Monitor_Header_H4",OBJPROP_BACK,0); 
 }
 ObjectSetInteger(0,"Monitor_Header_H4",OBJPROP_XDISTANCE,临_in_47); 
 ObjectSetInteger(0,"Monitor_Header_H4",OBJPROP_YDISTANCE,临_in_48); 
 ObjectSetString(0,"Monitor_Header_H4",OBJPROP_TEXT,临_st_46); 
 if ( 临_bo_43 )
 {
   临_st_49 = "Arial Bold";
 }
 else
 {
   临_st_49 = "Arial";
 }
 ObjectSetString(0,"Monitor_Header_H4",OBJPROP_FONT,临_st_49); 
 ObjectSetInteger(0,"Monitor_Header_H4",OBJPROP_FONTSIZE,临_in_45); 
 ObjectSetInteger(0,"Monitor_Header_H4",OBJPROP_COLOR,临_ui_44); 
 临_bo_50 = true;
 临_ui_51 = Yellow;
 临_in_52 = 总_226_in_DE4;
 临_st_53 = "信号";
 临_in_54 = MonitorPanelX + (子_15_in + 5);
 临_in_55 = MonitorPanelY + 子_5_in;
 if ( ObjectFind("Monitor_Header_Signal") == -1 )
 {
   ObjectCreate(0,"Monitor_Header_Signal",OBJ_LABEL,0,0,0.0); 
   ObjectSetInteger(0,"Monitor_Header_Signal",OBJPROP_CORNER,0); 
   ObjectSetInteger(0,"Monitor_Header_Signal",OBJPROP_ANCHOR,0); 
   ObjectSetInteger(0,"Monitor_Header_Signal",OBJPROP_SELECTABLE,0); 
   ObjectSetInteger(0,"Monitor_Header_Signal",OBJPROP_BACK,0); 
 }
 ObjectSetInteger(0,"Monitor_Header_Signal",OBJPROP_XDISTANCE,临_in_54); 
 ObjectSetInteger(0,"Monitor_Header_Signal",OBJPROP_YDISTANCE,临_in_55); 
 ObjectSetString(0,"Monitor_Header_Signal",OBJPROP_TEXT,临_st_53); 
 if ( 临_bo_50 )
 {
   临_st_56 = "Arial Bold";
 }
 else
 {
   临_st_56 = "Arial";
 }
 ObjectSetString(0,"Monitor_Header_Signal",OBJPROP_FONT,临_st_56); 
 ObjectSetInteger(0,"Monitor_Header_Signal",OBJPROP_FONTSIZE,临_in_52); 
 ObjectSetInteger(0,"Monitor_Header_Signal",OBJPROP_COLOR,临_ui_51); 
 子_16_in = 26 ;
 子_17_in = 48 ;
 子_18_in_si5[0] = 子_10_in;
 子_18_in_si5[1] = 子_11_in;
 子_18_in_si5[2] = 子_12_in;
 子_18_in_si5[3] = 子_13_in;
 子_18_in_si5[4] = 子_14_in;
 子_19_in = MathMin(总_276_in_1500,ArraySize(总_275_st_14CC_ko)) ;
 for (子_20_in = 0 ; 子_20_in < 子_19_in ; 子_20_in ++)
 {
   if ( 子_20_in >= ArraySize(总_275_st_14CC_ko) || 子_20_in >= 总_276_in_1500 )   break;
   子_21_in=子_17_in + 子_20_in * 子_16_in;
   子_22_st = 总_275_st_14CC_ko[子_20_in] ;
   子_23_st="Monitor_Symbol_" + IntegerToString(子_20_in,0,32);
   临_bo_57 = true;
   临_ui_58 = White;
   临_in_59 = 总_226_in_DE4;
   临_st_60 = 子_22_st;
   临_in_61 = MonitorPanelX + 子_9_in;
   临_in_62 = MonitorPanelY + 子_21_in;
   if ( ObjectFind(子_23_st) == -1 )
   {
     ObjectCreate(0,子_23_st,OBJ_LABEL,0,0,0.0); 
     ObjectSetInteger(0,子_23_st,OBJPROP_CORNER,0); 
     ObjectSetInteger(0,子_23_st,OBJPROP_ANCHOR,0); 
     ObjectSetInteger(0,子_23_st,OBJPROP_SELECTABLE,0); 
     ObjectSetInteger(0,子_23_st,OBJPROP_BACK,0); 
   }
   ObjectSetInteger(0,子_23_st,OBJPROP_XDISTANCE,临_in_61); 
   ObjectSetInteger(0,子_23_st,OBJPROP_YDISTANCE,临_in_62); 
   ObjectSetString(0,子_23_st,OBJPROP_TEXT,临_st_60); 
   if ( 临_bo_57 )
   {
     临_st_63 = "Arial Bold";
   }
   else
   {
     临_st_63 = "Arial";
   }
   ObjectSetString(0,子_23_st,OBJPROP_FONT,临_st_63); 
   ObjectSetInteger(0,子_23_st,OBJPROP_FONTSIZE,临_in_59); 
   ObjectSetInteger(0,子_23_st,OBJPROP_COLOR,临_ui_58); 
   if ( 总_225_bo_DE0 && ObjectFind(子_23_st) != -1 )
   {
     ObjectSetInteger(0,子_23_st,OBJPROP_SELECTABLE,0x1); 
   }
   for (子_24_in = 0 ; 子_24_in < 5 ; 子_24_in ++)
   {
     子_25_in=子_20_in * 5 + 子_24_in;
     if ( 子_25_in >= ArraySize(总_277_in_1504_ko) )   break;
     子_26_in = 总_277_in_1504_ko[子_25_in] ;
     子_27_in = 子_18_in_si5[子_24_in] ;
     子_28_ui = 总_231_ui_DF8 ;
     if ( 子_26_in >= 总_232_in_DFC )
     {
       子_28_ui = 总_229_ui_DF0 ;
     }
     else
     {
       if ( 子_26_in <= 100 - 总_232_in_DFC )
       {
         子_28_ui = 总_230_ui_DF4 ;
       }
     }
     子_29_st = "Monitor_Cell_" + IntegerToString(子_20_in,0,32) + "_" + IntegerToString(子_24_in,0,32) ;
     if ( ObjectFind(子_29_st) == -1 )
     {
       ObjectCreate(0,子_29_st,OBJ_RECTANGLE_LABEL,0,0,0.0); 
       ObjectSetInteger(0,子_29_st,OBJPROP_CORNER,0); 
       ObjectSetInteger(0,子_29_st,OBJPROP_BACK,0); 
       ObjectSetInteger(0,子_29_st,OBJPROP_SELECTABLE,0); 
     }
     ObjectSetInteger(0,子_29_st,OBJPROP_XDISTANCE,MonitorPanelX + 子_27_in - 2); 
     ObjectSetInteger(0,子_29_st,OBJPROP_YDISTANCE,MonitorPanelY + 子_21_in - 2); 
     ObjectSetInteger(0,子_29_st,OBJPROP_XSIZE,子_7_in - 4); 
     ObjectSetInteger(0,子_29_st,OBJPROP_YSIZE,子_16_in - 6); 
     ObjectSetInteger(0,子_29_st,OBJPROP_BGCOLOR,子_28_ui); 
     子_30_st = "Monitor_Value_" + IntegerToString(子_20_in,0,32) + "_" + IntegerToString(子_24_in,0,32) ;
     临_bo_64 = true;
     临_ui_65 = White;
     临_in_66 = 总_226_in_DE4;
     临_st_67 = IntegerToString(子_26_in,0,32);
     临_in_68 = MonitorPanelX + (子_27_in + 15);
     临_in_69 = MonitorPanelY + 子_21_in;
     if ( ObjectFind(子_30_st) == -1 )
     {
       ObjectCreate(0,子_30_st,OBJ_LABEL,0,0,0.0); 
       ObjectSetInteger(0,子_30_st,OBJPROP_CORNER,0); 
       ObjectSetInteger(0,子_30_st,OBJPROP_ANCHOR,0); 
       ObjectSetInteger(0,子_30_st,OBJPROP_SELECTABLE,0); 
       ObjectSetInteger(0,子_30_st,OBJPROP_BACK,0); 
     }
     ObjectSetInteger(0,子_30_st,OBJPROP_XDISTANCE,临_in_68); 
     ObjectSetInteger(0,子_30_st,OBJPROP_YDISTANCE,临_in_69); 
     ObjectSetString(0,子_30_st,OBJPROP_TEXT,临_st_67); 
     if ( 临_bo_64 )
     {
       临_st_70 = "Arial Bold";
     }
     else
     {
       临_st_70 = "Arial";
     }
     ObjectSetString(0,子_30_st,OBJPROP_FONT,临_st_70); 
     ObjectSetInteger(0,子_30_st,OBJPROP_FONTSIZE,临_in_66); 
     ObjectSetInteger(0,子_30_st,OBJPROP_COLOR,临_ui_65); 
   }
   子_31_in=子_20_in * 5 + 1;
   子_32_in=子_20_in * 5 + 2;
   if ( 子_32_in >= ArraySize(总_277_in_1504_ko) )
   {
   }
   else
   {
     子_33_in = 总_277_in_1504_ko[子_31_in] ;
     子_34_in = 总_277_in_1504_ko[子_32_in] ;
     子_35_st = "" ;
     子_36_ui = Gray ;
     if ( 子_33_in >= 总_232_in_DFC && 子_34_in >= 总_232_in_DFC )
     {
       子_35_st = "伺机进多" ;
       子_36_ui = 总_229_ui_DF0 ;
     }
     else
     {
       if ( 子_33_in <= 100 - 总_232_in_DFC && 子_34_in <= 100 - 总_232_in_DFC )
       {
         子_35_st = "伺机进空" ;
         子_36_ui = 总_230_ui_DF4 ;
       }
       else
       {
         子_35_st = "wait..." ;
         子_36_ui = Gray ;
       }
     }
     子_37_st="Monitor_Signal_" + IntegerToString(子_20_in,0,32);
     临_bo_71 = true;
     临_ui_72 = 子_36_ui;
     临_in_73 = 总_226_in_DE4;
     临_st_74 = 子_35_st;
     临_in_75 = MonitorPanelX + (子_15_in + 5);
     临_in_76 = MonitorPanelY + 子_21_in;
     if ( ObjectFind(子_37_st) == -1 )
     {
       ObjectCreate(0,子_37_st,OBJ_LABEL,0,0,0.0); 
       ObjectSetInteger(0,子_37_st,OBJPROP_CORNER,0); 
       ObjectSetInteger(0,子_37_st,OBJPROP_ANCHOR,0); 
       ObjectSetInteger(0,子_37_st,OBJPROP_SELECTABLE,0); 
       ObjectSetInteger(0,子_37_st,OBJPROP_BACK,0); 
     }
     ObjectSetInteger(0,子_37_st,OBJPROP_XDISTANCE,临_in_75); 
     ObjectSetInteger(0,子_37_st,OBJPROP_YDISTANCE,临_in_76); 
     ObjectSetString(0,子_37_st,OBJPROP_TEXT,临_st_74); 
     if ( 临_bo_71 )
     {
       临_st_77 = "Arial Bold";
     }
     else
     {
       临_st_77 = "Arial";
     }
     ObjectSetString(0,子_37_st,OBJPROP_FONT,临_st_77); 
     ObjectSetInteger(0,子_37_st,OBJPROP_FONTSIZE,临_in_73); 
     ObjectSetInteger(0,子_37_st,OBJPROP_COLOR,临_ui_72); 
   }
 }
 lizong_30(子_17_in,子_16_in); 
 }
//lizong_28 <<==--------   --------
 void lizong_29()
 {
  datetime  子_1_da;
  int       子_2_in;
  int       子_3_in;
  string    子_4_st;
  int       子_5_in;
  int       子_6_in;
  int       子_7_in;
  int       子_8_in;
  int       子_9_in;
  int       子_10_in;
  int       子_11_in;
  string    子_12_st;
  bool      子_13_bo;
//----- -----
 int        临_in_1;

 if ( !(MonitorAlertEnabled) )   return;
 子_1_da = TimeCurrent() ;
 子_2_in = -1 ;
 子_3_in = 0 ;
 子_4_st = "" ;
 for (子_5_in = 0 ; 子_5_in < 总_276_in_1500 ; 子_5_in ++)
 {
   if ( 子_5_in >= ArraySize(总_275_st_14CC_ko) || 子_5_in >= ArraySize(总_280_in_1548_ko) )   break;
   子_6_in=子_5_in * 5 + 1;
   子_7_in=子_5_in * 5 + 2;
   if ( 子_7_in >= ArraySize(总_277_in_1504_ko) )   break;
   子_8_in = 总_277_in_1504_ko[子_6_in] ;
   子_9_in = 总_277_in_1504_ko[子_7_in] ;
   子_10_in = 0 ;
   子_11_in = 0 ;
   子_12_st = "" ;
   if ( 子_8_in >= 总_232_in_DFC && 子_9_in >= 总_232_in_DFC )
   {
     子_10_in = 1 ;
     子_11_in=(子_8_in + 子_9_in) / 2;
     子_12_st = StringFormat("【做多机会】%s M5:%d↑ M15:%d↑ 强度:%d 伺机做多！",总_275_st_14CC_ko[子_5_in],子_8_in,子_9_in,子_11_in) ;
   }
   else
   {
     临_in_1=100 - 总_232_in_DFC;
     if ( 子_8_in <= 临_in_1 && 子_9_in <= 临_in_1 )
     {
       子_10_in = -1 ;
       临_in_1=100 - 子_8_in;
       临_in_1=临_in_1 + 100;
       临_in_1=临_in_1 - 子_9_in;
       子_11_in=(临_in_1) / 2;
       子_12_st = StringFormat("【做空机会】%s M5:%d↓ M15:%d↓ 强度:%d 伺机做空！",总_275_st_14CC_ko[子_5_in],子_8_in,子_9_in,子_11_in) ;
     }
   }
   子_13_bo = false ;
   if ( 子_10_in != 0 )
   {
     if ( 子_10_in != 总_280_in_1548_ko[子_5_in] )
     {
       子_13_bo = true ;
     }
     else
     {
       if ( 子_1_da - 总_281_da_157C_ko[子_5_in] >= 总_224_in_DDC )
       {
         子_13_bo = true ;
       }
     }
   }
   if ( 子_13_bo && 子_11_in >  子_3_in )
   {
     子_2_in = 子_5_in ;
     子_3_in = 子_11_in ;
     子_4_st = 子_12_st ;
   }
   总_280_in_1548_ko[子_5_in] = 子_10_in;
 }
 if ( 子_2_in >= 0 )
 {
   if ( AlertWithSound )
   {
     Alert(子_4_st); 
   }
   else
   {
     Print(子_4_st); 
   }
   总_281_da_157C_ko[子_2_in] = 子_1_da;
   总_279_lo_1540 = 子_1_da ;
 }
 }
//lizong_29 <<==--------   --------
 void lizong_30( int 木_0_in,int 木_1_in)
 {
  int       子_1_in = 0;
  int       子_2_in = 0;
  int       子_3_in = 0;
  int       子_4_in = 0;
  string    子_5_st;
  int       子_6_in;
  int       子_7_in;
  int       子_8_in;
  int       子_9_in;
  int       子_10_in;
  int       子_11_in;
  string    子_12_st;
  int       子_13_in;
  int       子_14_in;
  int       子_15_in;
  int       子_16_in;
  int       子_17_in;
  int       子_18_in;
  int       子_19_in;
  int       子_20_in;
  int       子_21_in;
  int       子_22_in;
  int       子_23_in;
  int       子_24_in;
  int       子_25_in;
  int       子_26_in;
  int       子_27_in;
  int       子_28_in;
  int       子_29_in;
  int       子_30_in;
  int       子_31_in;
  int       子_32_in;
  int       子_33_in;
  bool      子_34_bo;
  int       子_35_in;
  bool      子_36_bo;
  string    子_37_st;
  int       子_38_in;
  int       子_39_in;
  int       子_40_in;
  int       子_41_in;
  string    子_42_st;
  string    子_43_st;
  string    子_44_st;
  uint      子_45_ui;
  string    子_46_st;
  uint      子_47_ui;
  string    子_48_st;
  int       子_49_in;
  int       子_50_in;
  string    子_51_st;
  int       子_52_in;
  int       子_53_in;
  string    子_54_st;
  string    子_55_st;
  uint      子_56_ui;
  int       子_57_in;
  string    子_58_st;
  string    子_59_st;
  string    子_60_st;
  uint      子_61_ui;
//----- -----
 int        临_in_1;
 int        临_in_2;
 bool       临_bo_3;
 uint       临_ui_4;
 int        临_in_5;
 string     临_st_6;
 int        临_in_7;
 int        临_in_8;
 string     临_st_9;
 bool       临_bo_10;
 uint       临_ui_11;
 int        临_in_12;
 string     临_st_13;
 int        临_in_14;
 int        临_in_15;
 string     临_st_16;
 bool       临_bo_17;
 uint       临_ui_18;
 int        临_in_19;
 string     临_st_20;
 int        临_in_21;
 int        临_in_22;
 string     临_st_23;
 bool       临_bo_24;
 uint       临_ui_25;
 int        临_in_26;
 string     临_st_27;
 int        临_in_28;
 int        临_in_29;
 string     临_st_30;

 子_5_st = "" ;
 子_6_in = 0 ;
 子_7_in = 0 ;
 子_8_in = 0 ;
 子_9_in = 0 ;
 子_10_in = 0 ;
 子_11_in = 0 ;
 子_12_st = "" ;
 子_13_in = 0 ;
 子_14_in = 0 ;
 子_15_in = 0 ;
 子_16_in = 0 ;
 子_17_in = 0 ;
 子_18_in = 0 ;
 子_19_in = MathMin(总_276_in_1500,ArraySize(总_275_st_14CC_ko)) ;
 for (子_20_in = 0 ; 子_20_in < 子_19_in ; 子_20_in ++)
 {
   if ( 子_20_in >= ArraySize(总_275_st_14CC_ko) || 子_20_in >= 总_276_in_1500 )   break;
   子_21_in=子_20_in * 5;
   子_22_in=子_21_in + 1;
   子_23_in=子_21_in + 2;
   子_24_in=子_21_in + 3;
   子_25_in=子_21_in + 4;
   if ( 子_25_in >= ArraySize(总_277_in_1504_ko) )   break;
   子_26_in = 总_277_in_1504_ko[子_21_in] ;
   子_27_in = 总_277_in_1504_ko[子_22_in] ;
   子_28_in = 总_277_in_1504_ko[子_23_in] ;
   子_29_in = 总_277_in_1504_ko[子_24_in] ;
   子_30_in = 总_277_in_1504_ko[子_25_in] ;
   子_31_in = 0 ;
   子_32_in = 0 ;
   if ( 子_27_in >= 总_232_in_DFC )
   {
     子_31_in = 1 ;
   }
   if ( 子_28_in >= 总_232_in_DFC )
   {
     子_31_in ++;
   }
   if ( 子_29_in >= 总_232_in_DFC )
   {
     子_31_in ++;
   }
   if ( 子_30_in >= 总_232_in_DFC )
   {
     子_31_in ++;
   }
   if ( 子_27_in <= 100 - 总_232_in_DFC )
   {
     子_32_in ++;
   }
   if ( 子_28_in <= 100 - 总_232_in_DFC )
   {
     子_32_in ++;
   }
   if ( 子_29_in <= 100 - 总_232_in_DFC )
   {
     子_32_in ++;
   }
   if ( 子_30_in <= 100 - 总_232_in_DFC )
   {
     子_32_in ++;
   }
   if ( 子_27_in >= 总_232_in_DFC && 子_28_in >= 总_232_in_DFC )
   {
     子_1_in ++;
     子_33_in=(子_27_in * 35 + 子_28_in * 35 + 子_29_in * 15 + 子_30_in * 15) / 100;
     子_34_bo = 子_31_in>=3 ;
     if ( 子_34_bo )
     {
       子_4_in ++;
     }
     if ( 子_33_in <= 子_6_in )   continue;
     子_6_in = 子_33_in ;
     子_5_st = 总_275_st_14CC_ko[子_20_in] ;
     子_7_in = 子_27_in ;
     子_8_in = 子_28_in ;
     子_9_in = 子_29_in ;
     子_10_in = 子_30_in ;
     子_11_in = 子_31_in ;
      continue;
   }
   临_in_1=100 - 总_232_in_DFC;
   if ( 子_27_in <= 临_in_1 && 子_28_in <= 临_in_1 )
   {
     子_2_in ++;
     临_in_1=100 - 子_27_in;
     临_in_1=(临_in_1) * 35;
     子_35_in=(临_in_1 + (100 - 子_28_in) * 35 + (100 - 子_29_in) * 15 + (100 - 子_30_in) * 15) / 100;
     子_36_bo = 子_32_in>=3 ;
     if ( 子_36_bo )
     {
       子_4_in ++;
     }
     if ( 子_35_in <= 子_13_in )   continue;
     子_13_in = 子_35_in ;
     子_12_st = 总_275_st_14CC_ko[子_20_in] ;
     子_14_in = 子_27_in ;
     子_15_in = 子_28_in ;
     子_16_in = 子_29_in ;
     子_17_in = 子_30_in ;
     子_18_in = 子_32_in ;
      continue;
   }
   子_3_in ++;
   
 }
 子_37_st = "" ;
 子_38_in = TimeHour(TimeCurrent()) ;
 if ( 子_38_in >= 0 && 子_38_in <  8 )
 {
   子_37_st = "亚洲盘" ;
 }
 else
 {
   if ( 子_38_in >= 8 && 子_38_in <  16 )
   {
     子_37_st = "欧洲盘" ;
   }
   else
   {
     子_37_st = "美洲盘" ;
   }
 }
 子_39_in = 总_276_in_1500 ;
 if ( 总_276_in_1500 >  0 )
 {
   临_in_2 = 子_1_in * 100 / 总_276_in_1500;
 }
 else
 {
   临_in_2 = 50;
 }
 子_40_in = 临_in_2 ;
 子_41_in=木_0_in + 总_276_in_1500 * 木_1_in + 8;
 子_42_st = "" ;
 子_43_st = "" ;
 子_44_st = "" ;
 子_45_ui = Gray ;
 if ( 子_1_in >  总_276_in_1500 / 2 )
 {
   子_43_st = "多头占优" ;
   子_44_st = "▲" ;
   子_45_ui = Red ;
 }
 else
 {
   if ( 子_2_in >  总_276_in_1500 / 2 )
   {
     子_43_st = "空头主导" ;
     子_44_st = "▼" ;
     子_45_ui = LimeGreen ;
   }
   else
   {
     if ( 子_3_in >  总_276_in_1500 / 2 )
     {
       子_43_st = "震荡为主" ;
       子_44_st = "■" ;
       子_45_ui = Gray ;
     }
     else
     {
       子_43_st = "多空分化" ;
       子_44_st = "◆" ;
       子_45_ui = Yellow ;
     }
   }
 }
 子_42_st = StringFormat("【市场】%s %s | 情绪:%d%% | 做多:%d 做空:%d 震荡:%d | 共振:%d | %s",子_44_st,子_43_st,子_40_in,子_1_in,子_2_in,子_3_in,子_4_in,子_37_st) ;
 子_46_st = "" ;
 子_47_ui = White ;
 子_48_st = "" ;
 if ( 子_6_in >  子_13_in && 子_5_st != "" )
 {
   for (子_49_in = 0 ; 子_49_in < 子_11_in ; 子_49_in ++)
   {
     子_48_st +="★";
   }
   for (子_50_in = 子_11_in ; 子_50_in < 4 ; 子_50_in ++)
   {
     子_48_st +="☆";
   }
   子_51_st = "" ;
   if ( 子_6_in >= 80 )
   {
     子_51_st = "[极强]" ;
   }
   else
   {
     if ( 子_6_in >= 70 )
     {
       子_51_st = "[强势]" ;
     }
     else
     {
       子_51_st = "[中等]" ;
     }
   }
   子_46_st = StringFormat("【推荐】%s%s 做多↑ %s | M5:%d M15:%d H1:%d H4:%d | 综合:%d | 共振:%s",子_48_st,子_5_st,子_51_st,子_7_in,子_8_in,子_9_in,子_10_in,子_6_in,子_48_st) ;
   子_47_ui = Red ;
 }
 else
 {
   if ( 子_13_in >  0 && 子_12_st != "" )
   {
     for (子_52_in = 0 ; 子_52_in < 子_18_in ; 子_52_in ++)
     {
       子_48_st +="★";
     }
     for (子_53_in = 子_18_in ; 子_53_in < 4 ; 子_53_in ++)
     {
       子_48_st +="☆";
     }
     子_54_st = "" ;
     if ( 子_13_in >= 80 )
     {
       子_54_st = "[极强]" ;
     }
     else
     {
       if ( 子_13_in >= 70 )
       {
         子_54_st = "[强势]" ;
       }
       else
       {
         子_54_st = "[中等]" ;
       }
     }
     子_46_st = StringFormat("【推荐】%s%s 做空↓ %s | M5:%d M15:%d H1:%d H4:%d | 综合:%d | 共振:%s",子_48_st,子_12_st,子_54_st,子_14_in,子_15_in,子_16_in,子_17_in,子_13_in,子_48_st) ;
     子_47_ui = LimeGreen ;
   }
   else
   {
     子_46_st = "【推荐】当前无明确交易机会，所有品种M5-M15未同向，建议观望等待" ;
     子_47_ui = Gray ;
   }
 }
 子_55_st = "" ;
 子_56_ui = 0x969696 ;
 子_57_in=子_1_in + 子_2_in;
 子_58_st = "" ;
 子_59_st = "" ;
 if ( 子_57_in >= 5 && 子_4_in >= 3 )
 {
   子_58_st = "【低风险】" ;
   子_59_st = "趋势强劲+多品种共振,可积极交易,优先选择3星级以上品种" ;
   子_56_ui = Lime ;
 }
 else
 {
   if ( 子_57_in >= 5 )
   {
     子_58_st = "【中低风险】" ;
     子_59_st = StringFormat("趋势明朗,%d个信号,共振%d个,建议分批建仓",子_57_in,子_4_in) ;
     子_56_ui = 0x96C896 ;
   }
   else
   {
     if ( 子_57_in >= 3 && 子_4_in >= 2 )
     {
       子_58_st = "【中等风险】" ;
       子_59_st = StringFormat("机会适中,%d个信号含%d个共振,选强度最高品种小仓试探",子_57_in,子_4_in) ;
       子_56_ui = Yellow ;
     }
     else
     {
       if ( 子_57_in >= 3 )
       {
         子_58_st = "【中等风险】" ;
         子_59_st = StringFormat("有%d个交易机会但共振少,建议等待更强信号或轻仓操作",子_57_in) ;
         子_56_ui = Yellow ;
       }
       else
       {
         if ( 子_57_in >= 1 )
         {
           子_58_st = "【中高风险】" ;
           子_59_st = StringFormat("机会稀少,仅%d个信号,谨慎入场,严格止损",子_57_in) ;
           子_56_ui = Orange ;
         }
         else
         {
           子_58_st = "【高风险】" ;
           子_59_st = "市场震荡,所有品种M5-M15未同向,强烈建议观望等待" ;
           子_56_ui = Red ;
         }
       }
     }
   }
 }
 子_55_st = 子_58_st + " " + 子_59_st ;
 子_60_st = "" ;
 子_61_ui = 0x787878 ;
 if ( 子_37_st == "亚洲盘" )
 {
   子_60_st = "【时段】亚洲盘 | 波动小,适合区间操作 | 等欧盘关注JPY系" ;
 }
 else
 {
   if ( 子_37_st == "欧洲盘" )
   {
     子_60_st = "【时段】欧洲盘 | 波动加大,趋势启动 | 关注EUR/GBP顺势交易" ;
     子_61_ui = 0xB49696 ;
   }
   else
   {
     子_60_st = "【时段】美洲盘 | 波动最大,数据密集 | 关注USD系严格止损" ;
     子_61_ui = 0x9696B4 ;
   }
 }
 临_bo_3 = false;
 临_ui_4 = 子_45_ui;
 临_in_5 = 总_226_in_DE4 - 1;
 临_st_6 = 子_42_st;
 临_in_7 = MonitorPanelX + 10;
 临_in_8 = MonitorPanelY + (子_41_in - 15);
 if ( ObjectFind("Monitor_SmartFooter1") == -1 )
 {
   ObjectCreate(0,"Monitor_SmartFooter1",OBJ_LABEL,0,0,0.0); 
   ObjectSetInteger(0,"Monitor_SmartFooter1",OBJPROP_CORNER,0); 
   ObjectSetInteger(0,"Monitor_SmartFooter1",OBJPROP_ANCHOR,0); 
   ObjectSetInteger(0,"Monitor_SmartFooter1",OBJPROP_SELECTABLE,0); 
   ObjectSetInteger(0,"Monitor_SmartFooter1",OBJPROP_BACK,0); 
 }
 ObjectSetInteger(0,"Monitor_SmartFooter1",OBJPROP_XDISTANCE,临_in_7); 
 ObjectSetInteger(0,"Monitor_SmartFooter1",OBJPROP_YDISTANCE,临_in_8); 
 ObjectSetString(0,"Monitor_SmartFooter1",OBJPROP_TEXT,临_st_6); 
 if ( 临_bo_3 )
 {
   临_st_9 = "Arial Bold";
 }
 else
 {
   临_st_9 = "Arial";
 }
 ObjectSetString(0,"Monitor_SmartFooter1",OBJPROP_FONT,临_st_9); 
 ObjectSetInteger(0,"Monitor_SmartFooter1",OBJPROP_FONTSIZE,临_in_5); 
 ObjectSetInteger(0,"Monitor_SmartFooter1",OBJPROP_COLOR,临_ui_4); 
 临_bo_10 = false;
 临_ui_11 = 子_47_ui;
 临_in_12 = 总_226_in_DE4 - 1;
 临_st_13 = 子_46_st;
 临_in_14 = MonitorPanelX + 10;
 临_in_15 = MonitorPanelY + (子_41_in - 2);
 if ( ObjectFind("Monitor_SmartFooter2") == -1 )
 {
   ObjectCreate(0,"Monitor_SmartFooter2",OBJ_LABEL,0,0,0.0); 
   ObjectSetInteger(0,"Monitor_SmartFooter2",OBJPROP_CORNER,0); 
   ObjectSetInteger(0,"Monitor_SmartFooter2",OBJPROP_ANCHOR,0); 
   ObjectSetInteger(0,"Monitor_SmartFooter2",OBJPROP_SELECTABLE,0); 
   ObjectSetInteger(0,"Monitor_SmartFooter2",OBJPROP_BACK,0); 
 }
 ObjectSetInteger(0,"Monitor_SmartFooter2",OBJPROP_XDISTANCE,临_in_14); 
 ObjectSetInteger(0,"Monitor_SmartFooter2",OBJPROP_YDISTANCE,临_in_15); 
 ObjectSetString(0,"Monitor_SmartFooter2",OBJPROP_TEXT,临_st_13); 
 if ( 临_bo_10 )
 {
   临_st_16 = "Arial Bold";
 }
 else
 {
   临_st_16 = "Arial";
 }
 ObjectSetString(0,"Monitor_SmartFooter2",OBJPROP_FONT,临_st_16); 
 ObjectSetInteger(0,"Monitor_SmartFooter2",OBJPROP_FONTSIZE,临_in_12); 
 ObjectSetInteger(0,"Monitor_SmartFooter2",OBJPROP_COLOR,临_ui_11); 
 临_bo_17 = false;
 临_ui_18 = 子_56_ui;
 临_in_19 = 总_226_in_DE4 - 1;
 临_st_20 = 子_55_st;
 临_in_21 = MonitorPanelX + 10;
 临_in_22 = MonitorPanelY + (子_41_in + 12);
 if ( ObjectFind("Monitor_SmartFooter3") == -1 )
 {
   ObjectCreate(0,"Monitor_SmartFooter3",OBJ_LABEL,0,0,0.0); 
   ObjectSetInteger(0,"Monitor_SmartFooter3",OBJPROP_CORNER,0); 
   ObjectSetInteger(0,"Monitor_SmartFooter3",OBJPROP_ANCHOR,0); 
   ObjectSetInteger(0,"Monitor_SmartFooter3",OBJPROP_SELECTABLE,0); 
   ObjectSetInteger(0,"Monitor_SmartFooter3",OBJPROP_BACK,0); 
 }
 ObjectSetInteger(0,"Monitor_SmartFooter3",OBJPROP_XDISTANCE,临_in_21); 
 ObjectSetInteger(0,"Monitor_SmartFooter3",OBJPROP_YDISTANCE,临_in_22); 
 ObjectSetString(0,"Monitor_SmartFooter3",OBJPROP_TEXT,临_st_20); 
 if ( 临_bo_17 )
 {
   临_st_23 = "Arial Bold";
 }
 else
 {
   临_st_23 = "Arial";
 }
 ObjectSetString(0,"Monitor_SmartFooter3",OBJPROP_FONT,临_st_23); 
 ObjectSetInteger(0,"Monitor_SmartFooter3",OBJPROP_FONTSIZE,临_in_19); 
 ObjectSetInteger(0,"Monitor_SmartFooter3",OBJPROP_COLOR,临_ui_18); 
 临_bo_24 = false;
 临_ui_25 = 子_61_ui;
 临_in_26 = 总_226_in_DE4 - 1;
 临_st_27 = 子_60_st;
 临_in_28 = MonitorPanelX + 10;
 临_in_29 = MonitorPanelY + (子_41_in + 26);
 if ( ObjectFind("Monitor_SmartFooter4") == -1 )
 {
   ObjectCreate(0,"Monitor_SmartFooter4",OBJ_LABEL,0,0,0.0); 
   ObjectSetInteger(0,"Monitor_SmartFooter4",OBJPROP_CORNER,0); 
   ObjectSetInteger(0,"Monitor_SmartFooter4",OBJPROP_ANCHOR,0); 
   ObjectSetInteger(0,"Monitor_SmartFooter4",OBJPROP_SELECTABLE,0); 
   ObjectSetInteger(0,"Monitor_SmartFooter4",OBJPROP_BACK,0); 
 }
 ObjectSetInteger(0,"Monitor_SmartFooter4",OBJPROP_XDISTANCE,临_in_28); 
 ObjectSetInteger(0,"Monitor_SmartFooter4",OBJPROP_YDISTANCE,临_in_29); 
 ObjectSetString(0,"Monitor_SmartFooter4",OBJPROP_TEXT,临_st_27); 
 if ( 临_bo_24 )
 {
   临_st_30 = "Arial Bold";
 }
 else
 {
   临_st_30 = "Arial";
 }
 ObjectSetString(0,"Monitor_SmartFooter4",OBJPROP_FONT,临_st_30); 
 ObjectSetInteger(0,"Monitor_SmartFooter4",OBJPROP_FONTSIZE,临_in_26); 
 ObjectSetInteger(0,"Monitor_SmartFooter4",OBJPROP_COLOR,临_ui_25); 
 }
//lizong_30 <<==--------   --------
 void lizong_31()
 {
  string    子_1_st;
  string    子_2_st;
  int       子_3_in;
  datetime  子_4_da;
  datetime  子_5_da;
  string    子_6_st;
  string    子_7_st;
  string    子_8_st;
  string    子_9_st;
  string    子_10_st;
  string    子_11_st;
//----- -----
 string     临_st_1;

 if ( !(ShowTopRightInfo) )
 {
   ObjectDelete("TopRight_Line1"); 
   ObjectDelete("TopRight_Line2"); 
   return;
 }
 子_1_st = Symbol() ;
 子_2_st = "" ;
 子_3_in = Period() ;
 switch(Period())
 {
   case 1 :
   子_2_st = "M1" ;
     break;
   case 5 :
   子_2_st = "M5" ;
     break;
   case 15 :
   子_2_st = "M15" ;
     break;
   case 30 :
   子_2_st = "M30" ;
     break;
   case 60 :
   子_2_st = "H1" ;
     break;
   case 240 :
   子_2_st = "H4" ;
     break;
   case 1440 :
   子_2_st = "D1" ;
     break;
   case 10080 :
   子_2_st = "W1" ;
     break;
   case 43200 :
   子_2_st = "MN" ;
     break;
   default :
   子_2_st="M" + IntegerToString(子_3_in,0,32);
 }
 子_4_da = TimeCurrent() ;
 子_5_da=子_4_da + BeijingTimeOffset * 3600;
 子_6_st = TimeToString(子_5_da,5) ;
 if ( BeijingTimeOffset >= 0 )
 {
   临_st_1 = "+" + IntegerToString(BeijingTimeOffset,0,32);
 }
 else
 {
   临_st_1 = IntegerToString(BeijingTimeOffset,0,32);
 }
 子_7_st = 临_st_1 ;
 子_8_st = 子_6_st + " (北京 " + 子_7_st + ")" ;
 子_9_st = 子_1_st + " " + 子_2_st ;
 子_10_st = "TopRight_Line1" ;
 子_11_st = "TopRight_Line2" ;
 if ( ObjectFind(子_10_st) == -1 )
 {
   ObjectCreate(0,子_10_st,OBJ_LABEL,0,0,0.0); 
   ObjectSetInteger(0,子_10_st,OBJPROP_CORNER,0x1); 
   ObjectSetInteger(0,子_10_st,OBJPROP_ANCHOR,0x6); 
   ObjectSetInteger(0,子_10_st,OBJPROP_SELECTABLE,0); 
   ObjectSetInteger(0,子_10_st,OBJPROP_BACK,0); 
 }
 ObjectSetInteger(0,子_10_st,OBJPROP_XDISTANCE,0xA); 
 ObjectSetInteger(0,子_10_st,OBJPROP_YDISTANCE,0x19); 
 ObjectSetString(0,子_10_st,OBJPROP_TEXT,子_8_st); 
 ObjectSetString(0,子_10_st,OBJPROP_FONT,"Arial"); 
 ObjectSetInteger(0,子_10_st,OBJPROP_FONTSIZE,0x9); 
 ObjectSetInteger(0,子_10_st,OBJPROP_COLOR,0xFFBF00); 
 if ( ObjectFind(子_11_st) == -1 )
 {
   ObjectCreate(0,子_11_st,OBJ_LABEL,0,0,0.0); 
   ObjectSetInteger(0,子_11_st,OBJPROP_CORNER,0x1); 
   ObjectSetInteger(0,子_11_st,OBJPROP_ANCHOR,0x6); 
   ObjectSetInteger(0,子_11_st,OBJPROP_SELECTABLE,0); 
   ObjectSetInteger(0,子_11_st,OBJPROP_BACK,0); 
 }
 ObjectSetInteger(0,子_11_st,OBJPROP_XDISTANCE,0xA); 
 ObjectSetInteger(0,子_11_st,OBJPROP_YDISTANCE,0x28); 
 ObjectSetString(0,子_11_st,OBJPROP_TEXT,子_9_st); 
 ObjectSetString(0,子_11_st,OBJPROP_FONT,"Arial Bold"); 
 ObjectSetInteger(0,子_11_st,OBJPROP_FONTSIZE,0xF); 
 ObjectSetInteger(0,子_11_st,OBJPROP_COLOR,0xD7FF); 
 }
//lizong_31 <<==--------   --------
 void lizong_32()
 {
  double    子_1_do = 0.0;
  double    子_2_do;
  double    子_3_do;
  double    子_4_do;
  double    子_5_do;
  double    子_6_do;
//----- -----

 if ( iBars(NULL,总_234_in_E04) >  0 )
 {
   子_2_do = iHigh(NULL,总_234_in_E04,0) ;
   子_3_do = iLow(NULL,总_234_in_E04,0) ;
   if ( 子_2_do>0.0 && 子_3_do>0.0 && Point>0.0 )
   {
     子_1_do = (子_2_do - 子_3_do) / Point ;
   }
 }
 if ( 子_1_do>0.0 )
 {
   总_249_do_F40 = 子_1_do * 总_152_do_C58 ;
 }
 else
 {
   if ( 总_242_do_E40>0.0 )
   {
     总_249_do_F40 = 总_242_do_E40 * 总_152_do_C58 ;
   }
   else
   {
     总_249_do_F40 = 50.0 ;
   }
 }
 if ( 总_242_do_E40>0.0 && 子_1_do>0.0 )
 {
   子_4_do = 子_1_do / 总_242_do_E40 ;
   if ( 子_4_do<0.5 )
   {
     总_250_do_F48 = 0.3 ;
   }
   else
   {
     if ( 子_4_do<0.7 )
     {
       总_250_do_F48 = 0.5 ;
     }
     else
     {
       if ( 子_4_do>=0.8 && 子_4_do<=1.3 )
       {
         总_250_do_F48 = 1.0 ;
       }
       else
       {
         if ( 子_4_do>1.3 && 子_4_do<=2.0 )
         {
           总_250_do_F48 = 0.8 ;
         }
         else
         {
           总_250_do_F48 = 0.5 ;
         }
       }
     }
   }
 }
 else
 {
   总_250_do_F48 = 1.0 ;
 }
 总_251_in_F50 = 5 ;
 if ( !(总_242_do_E40>0.0) || !(子_1_do>0.0) )   return;
 子_5_do = 子_1_do / 总_242_do_E40 ;
 子_6_do = 0.0 ;
 if ( 总_240_do_E30>总_241_do_E38 )
 {
   子_6_do = (子_1_do - 总_241_do_E38) / (总_240_do_E30 - 总_241_do_E38) * 100.0 ;
 }
 if ( 子_5_do<0.5 )
 {
   总_251_in_F50 = 2 ;
 }
 else
 {
   if ( 子_5_do<0.8 )
   {
     总_251_in_F50 = 4 ;
   }
   else
   {
     if ( 子_5_do<=1.2 )
     {
       总_251_in_F50 = 5 ;
     }
     else
     {
       if ( 子_5_do<=1.8 )
       {
         总_251_in_F50 = 7 ;
       }
       else
       {
         总_251_in_F50 = 9 ;
       }
     }
   }
 }
 if ( 总_246_do_F28>30.0 )
 {
   总_251_in_F50 = MathMin(总_251_in_F50 + 1,10) ;
 }
 else
 {
   if ( 总_246_do_F28<-30.0 )
   {
     总_251_in_F50 = MathMax(总_251_in_F50 - 1,1) ;
   }
 }
 if ( !(子_6_do>90.0) )   return;
 总_251_in_F50 = MathMin(总_251_in_F50 + 1,10) ;
 }
//lizong_32 <<==--------   --------
 void lizong_33()
 {
  datetime  子_1_da;
  double    子_2_do;
  int       子_3_in;
  int       子_4_in;
  double    子_5_do;
  double    子_6_do;
  double    子_7_do;
//----- -----
 double     临_do_1;
 double     临_do_2;
 int        临_in_3;
 int        临_in_4;
 double     临_do_5;
 double     临_do_6;
 int        临_in_7;
 double     临_do_8;
 double     临_do_9;

 子_1_da = iTime(NULL,总_234_in_E04,0) ;
 if ( 总_239_lo_E28 == 子_1_da )   return;
 总_239_lo_E28 = 子_1_da ;
 总_240_do_E30 = 0.0 ;
 总_241_do_E38 = DBL_MAX ;
 子_2_do = 0.0 ;
 子_3_in = 0 ;
 总_245_in_F24 = 0 ;

 for (子_4_in = 0 ;总_133_in_BE4 >  0 && 子_4_in < iBars(NULL,总_234_in_E04) ; 子_4_in ++)
 {
   子_5_do = iHigh(NULL,总_234_in_E04,子_4_in) ;
   子_6_do = iLow(NULL,总_234_in_E04,子_4_in) ;
   if ( 子_5_do>0.0 && 子_6_do>0.0 && Point>0.0 )
   {
     子_7_do = (子_5_do - 子_6_do) / Point ;
     总_240_do_E30 = MathMax(总_240_do_E30,子_7_do) ;
     总_241_do_E38 = MathMin(总_241_do_E38,子_7_do) ;
     子_2_do = 子_2_do + 子_7_do ;
     子_3_in ++;
     if ( 子_4_in <  总_146_in_C38 && 总_245_in_F24 <  20 )
     {
       总_244_do_E84_si20[总_245_in_F24] = 子_7_do;
       总_245_in_F24 ++;
     }
   }
   if ( 子_4_in >= 总_133_in_BE4 )   break;
   
 }

 if ( 子_3_in >  0 )
 {
   临_do_1 = 子_2_do / 子_3_in;
 }
 else
 {
   临_do_1 = 0.0;
 }
 总_242_do_E40 = 临_do_1 ;
 总_246_do_F28 = 0.0 ;
 if ( 总_245_in_F24 >= 3 && 总_245_in_F24 <= 20 )
 {
   if ( MathAbs(总_244_do_E84_si20[1] - 总_244_do_E84_si20[2])>0.1 )
   {
     总_246_do_F28 = (总_244_do_E84_si20[0] - 总_244_do_E84_si20[1] - (总_244_do_E84_si20[1] - 总_244_do_E84_si20[2])) / (总_244_do_E84_si20[1] - 总_244_do_E84_si20[2]) * 100.0 ;
     if ( 总_246_do_F28 <= 200 )
     {
       临_do_2 = 总_246_do_F28;
     }
     else
     {
       临_do_2 = 200.0;
     }
     总_246_do_F28 = (临_do_2 >= -200) ?临_do_2:-200.0  ;
   }
   else
   {
     总_246_do_F28 = 0.0 ;
   }
 }
 总_247_do_F30 = 0.0 ;
 总_248_do_F38 = 0.0 ;
 if ( 总_245_in_F24 >= 5 && !(总_242_do_E40<=0.0) )
 {
   临_in_3 = MathMin(总_245_in_F24,5);
   if ( 临_in_3 <= 0 )
   {
     Print("警告：recentCount为0，无法计算预测"); 
   }
  else
  {
    临_do_5 = 0.0;
    for (临_in_4 = 0 ; 临_in_4 < 临_in_3 ; 临_in_4=临_in_4 + 1)
    {
      临_do_5 = 0.0 + 总_244_do_E84_si20[临_in_4];
    }
    临_do_5 = (临_do_5) / 临_in_3;
     临_do_6 = 0.0;
     for (临_in_7 = 0 ; 临_in_7 < 临_in_3 ; 临_in_7=临_in_7 + 1)
     {
       临_do_6 = 临_do_6 + (MathPow(总_244_do_E84_si20[临_in_7] - 临_do_5,2.0));
     }
     临_do_6 = MathSqrt((临_do_6) / 临_in_3);
     临_do_8 = 1.28;
     if ( 总_149_in_C40 >= 90 )
     {
       临_do_8 = 1.64;
     }
     else
     {
       if ( 总_149_in_C40 >= 95 )
       {
         临_do_8 = 1.96;
       }
     }
     临_do_9 = 临_do_5 - (临_do_6) * 临_do_8;
     总_247_do_F30 = (临_do_9 >= 0) ?临_do_9:0.0  ;
     总_248_do_F38 = (临_do_6) * 临_do_8 + 临_do_5 ;
     if ( 总_240_do_E30>0.0 )
     {
       总_248_do_F38 = MathMin(总_248_do_F38,总_240_do_E30 * 1.5) ;
     }
   }
 }
 lizong_32(); 
 }
//lizong_33 <<==--------   --------
 void lizong_34()
 {
  int       子_1_in;
  string    子_2_st;
  double    子_3_do;
  double    子_4_do;
  double    子_5_do;
  double    子_6_do;
  int       子_7_in;
  uint      子_8_ui;
  uint      子_9_ui;
  uint      子_10_ui;
  int       子_11_in;
  int       子_12_in;
  string    子_13_st;
  int       子_14_in;
  uint      子_15_ui;
  string    子_16_st;
  int       子_17_in;
  int       子_18_in;
  int       子_19_in;
  uint      子_20_ui;
  string    子_21_st;
  string    子_22_st;
  int       子_23_in;
  int       子_24_in;
  uint      子_25_ui;
  string    子_26_st;
  string    子_27_st;
  uint      子_28_ui;
  string    子_29_st;
  string    子_30_st;
  uint      子_31_ui;
  string    子_32_st;
  string    子_33_st;
  string    子_34_st;
  string    子_35_st;
  uint      子_36_ui;
  string    子_37_st;
  string    子_38_st;
  int       子_39_in;
  uint      子_40_ui;
  string    子_41_st;
  uint      子_42_ui;
//----- -----
 bool       临_bo_1;
 int        临_in_2;
 bool       临_bo_3;
 uint       临_ui_4;
 int        临_in_5;
 int        临_in_6;
 int        临_in_7;
 string     临_st_8;
 string     临_st_9;
 uint       临_ui_10;
 double     临_do_11;
 bool       临_bo_12;
 uint       临_ui_13;
 int        临_in_14;
 int        临_in_15;
 int        临_in_16;
 string     临_st_17;
 string     临_st_18;
 bool       临_bo_19;
 uint       临_ui_20;
 uint       临_ui_21;
 int        临_in_22;
 int        临_in_23;
 int        临_in_24;
 string     临_st_25;
 string     临_st_26;
 bool       临_bo_27;
 uint       临_ui_28;
 uint       临_ui_29;
 int        临_in_30;
 int        临_in_31;
 int        临_in_32;
 string     临_st_33;
 string     临_st_34;
 bool       临_bo_35;
 uint       临_ui_36;
 int        临_in_37;
 int        临_in_38;
 int        临_in_39;
 string     临_st_40;
 string     临_st_41;
 bool       临_bo_42;
 uint       临_ui_43;
 int        临_in_44;
 int        临_in_45;
 int        临_in_46;
 string     临_st_47;
 string     临_st_48;
 bool       临_bo_49;
 uint       临_ui_50;
 int        临_in_51;
 int        临_in_52;
 int        临_in_53;
 string     临_st_54;
 string     临_st_55;
 bool       临_bo_56;
 uint       临_ui_57;
 int        临_in_58;
 int        临_in_59;
 int        临_in_60;
 string     临_st_61;
 string     临_st_62;
 bool       临_bo_63;
 uint       临_ui_64;
 int        临_in_65;
 int        临_in_66;
 int        临_in_67;
 string     临_st_68;
 string     临_st_69;
 uint       临_ui_70;
 bool       临_bo_71;
 uint       临_ui_72;
 int        临_in_73;
 int        临_in_74;
 int        临_in_75;
 string     临_st_76;
 string     临_st_77;
 bool       临_bo_78;
 uint       临_ui_79;
 int        临_in_80;
 int        临_in_81;
 int        临_in_82;
 string     临_st_83;
 string     临_st_84;
 uint       临_ui_85;
 double     临_do_86;
 bool       临_bo_87;
 uint       临_ui_88;
 int        临_in_89;
 int        临_in_90;
 int        临_in_91;
 string     临_st_92;
 string     临_st_93;

 if ( ( !(总_124_bo_BB6) || !(总_233_bo_E00) ) )
 {
   for (子_1_in=ObjectsTotal(-1) - 1 ; 子_1_in >= 0 ; 子_1_in --)
   {
     子_2_st = ObjectName(子_1_in) ;
     if ( ( StringFind(子_2_st,"VolStats_",0) == 0 || StringFind(子_2_st,"VolProgress_",0) == 0 || StringFind(子_2_st,"VolTrend_",0) == 0 || StringFind(子_2_st,"VolWarning_",0) == 0 ) )
     {
       ObjectDelete(子_2_st); 
     }
   }
   return;
 }
 子_3_do = 0.0 ;
 if ( iBars(NULL,总_234_in_E04) >  0 )
 {
   子_4_do = iHigh(NULL,总_234_in_E04,0) ;
   子_5_do = iLow(NULL,总_234_in_E04,0) ;
   if ( 子_4_do>0.0 && 子_5_do>0.0 && Point>0.0 )
   {
     子_3_do = (子_4_do - 子_5_do) / Point ;
   }
 }

 子_6_do = 0.0 ;

 if ( 总_240_do_E30>总_241_do_E38 )
 {
   
   子_6_do = (子_3_do - 总_241_do_E38) / (总_240_do_E30 - 总_241_do_E38) * 100.0 ;
 }
 
 临_bo_1 = 总_26_do_4BC_ko[0]!=INT_MAX;
 if ( 总_23_do_420_ko[0]!=INT_MAX )
 {
   临_in_2 = 1;
 }
 else
 {
   if ( 总_24_do_454_ko[0]!=INT_MAX )
   {
     临_in_2 = 2;
   }
   else
   {
     if ( 临_bo_1 )
     {
       临_in_2 = 3;
     }
     else
     {
       if ( 总_25_do_488_ko[0]!=INT_MAX )
       {
         临_in_2 = 4;
       }
       else
       {
         临_in_2 = 0;
       }
     }
   }
 }
 子_7_in = 临_in_2 ;
 
 子_8_ui = 0 ;
 子_9_ui = 0 ;
 子_10_ui = 0 ;
 
 if ( !(总_136_bo_BFC) )
 {
   子_8_ui = 总_142_ui_C1C;
   子_9_ui = 总_143_ui_C20;
   子_10_ui = 0x55463C;
 }
 else
 {
   switch(子_7_in)
   {
     case 1 :
     子_8_ui = 0x232350;
     子_9_ui = 0x323264;
     子_10_ui = 0x46468C;
       break;
     case 2 :
     子_8_ui = 0x323C1E;
     子_9_ui = 0x415028;
     子_10_ui = 0x5A783C;
       break;
     case 3 :
     子_8_ui = 0x37322D;
     子_9_ui = 0x46413C;
     子_10_ui = 0x645F5A;
       break;
     case 4 :
     子_8_ui = 0x1E3C46;
     子_9_ui = 0x2D505A;
     子_10_ui = 0x46788C;
       break;
     default :
     子_8_ui = 0x342A23;
     子_9_ui = 0x3E342D;
     子_10_ui = 0x5F5046;
   }
 }
 
 子_11_in = (总_155_bo_C62) ?180:230  ;

 子_12_in = 28 ;
 
 子_12_in +=60;
 
 子_12_in +=22;
 
 if ( 总_139_bo_C08 )
 {
   子_12_in +=16;
 }

 if ( 总_145_bo_C34 )
 {
   子_12_in +=20;
 }
 
 if ( 总_147_bo_C3C )
 {
   子_12_in +=18;
 }
 
 if ( 总_148_bo_C3D )
 {
   子_12_in +=18;
 }
 
 if ( 总_151_bo_C54 )
 {
   子_12_in +=18;
 }
 
 if ( 总_153_bo_C60 )
 {
   子_12_in +=18;
 }
 
 if ( 总_154_bo_C61 )
 {
   子_12_in +=18;
 }
 
 if ( 总_125_bo_BB7 && !(总_155_bo_C62) )
 {
   子_12_in +=28;
 }

 
 子_13_st = "VolStats_Panel_BG" ;
 if ( ObjectFind(子_13_st) == -1 )
 {
   ObjectCreate(0,子_13_st,OBJ_RECTANGLE_LABEL,0,0,0.0); 
   ObjectSetInteger(0,子_13_st,OBJPROP_CORNER,0); 
   ObjectSetInteger(0,子_13_st,OBJPROP_BORDER_TYPE,0x1); 
   ObjectSetInteger(0,子_13_st,OBJPROP_SELECTABLE,0); 
   ObjectSetInteger(0,子_13_st,OBJPROP_WIDTH,0x2); 
 }
 子_14_in = MathMin(MathMax(总_137_in_C00,0),255) ;
 子_15_ui=(总_138_ui_C04 & 0xFFFFFF) | (子_14_in << 0x18);
 ObjectSetInteger(0,子_13_st,OBJPROP_BGCOLOR,子_15_ui); 
 ObjectSetInteger(0,子_13_st,OBJPROP_BORDER_COLOR,子_10_ui); 
 ObjectSetInteger(0,子_13_st,OBJPROP_XDISTANCE,StatsPanelX); 
 ObjectSetInteger(0,子_13_st,OBJPROP_YDISTANCE,StatsPanelY); 
 ObjectSetInteger(0,子_13_st,OBJPROP_XSIZE,子_11_in); 
 ObjectSetInteger(0,子_13_st,OBJPROP_YSIZE,子_12_in); 
 子_16_st = "VolStats_Title_BG" ;
 if ( ObjectFind(子_16_st) == -1 )
 {
   ObjectCreate(0,子_16_st,OBJ_RECTANGLE_LABEL,0,0,0.0); 
   ObjectSetInteger(0,子_16_st,OBJPROP_CORNER,0); 
   ObjectSetInteger(0,子_16_st,OBJPROP_BORDER_TYPE,0); 
   ObjectSetInteger(0,子_16_st,OBJPROP_SELECTABLE,0); 
 }
 子_17_in=(int)(((子_8_ui & Red) + (子_9_ui & Red)) / 2);
 子_18_in=(int)((((子_8_ui >> 8) & Red) + ((子_9_ui >> 8) & Red)) / 2);
 子_19_in=(int)((((子_8_ui >> 16) & Red) + ((子_9_ui >> 16) & Red)) / 2);
 子_20_ui=子_17_in | (子_18_in << 8) | (子_19_in << 16);
 ObjectSetInteger(0,子_16_st,OBJPROP_BGCOLOR,子_20_ui); 
 ObjectSetInteger(0,子_16_st,OBJPROP_XDISTANCE,StatsPanelX); 
 ObjectSetInteger(0,子_16_st,OBJPROP_YDISTANCE,StatsPanelY); 
 ObjectSetInteger(0,子_16_st,OBJPROP_XSIZE,子_11_in); 
 ObjectSetInteger(0,子_16_st,OBJPROP_YSIZE,0x1A); 
 子_21_st = lizong_39(总_234_in_E04) ;
 子_22_st = (总_155_bo_C62) ?" [迷你]":""  ;
 临_bo_3 = true;
 临_ui_4 = White;
 临_in_5 = (总_155_bo_C62) ?9:10 ;
 临_in_6 = StatsPanelY + 6;
 临_in_7 = StatsPanelX + 8;
 临_st_8 = "【" + 子_21_st + " 波动分析】" + 子_22_st;
 if ( ObjectFind("VolStats_Title") == -1 )
 {
   ObjectCreate(0,"VolStats_Title",OBJ_LABEL,0,0,0.0); 
   ObjectSetInteger(0,"VolStats_Title",OBJPROP_CORNER,0); 
   ObjectSetInteger(0,"VolStats_Title",OBJPROP_ANCHOR,0); 
   ObjectSetInteger(0,"VolStats_Title",OBJPROP_SELECTABLE,0); 
 }
 ObjectSetInteger(0,"VolStats_Title",OBJPROP_XDISTANCE,临_in_7); 
 ObjectSetInteger(0,"VolStats_Title",OBJPROP_YDISTANCE,临_in_6); 
 ObjectSetString(0,"VolStats_Title",OBJPROP_TEXT,临_st_8); 
 if ( 临_bo_3 )
 {
   临_st_9 = "Arial Bold";
 }
 else
 {
   临_st_9 = "Arial";
 }
 ObjectSetString(0,"VolStats_Title",OBJPROP_FONT,临_st_9); 
 ObjectSetInteger(0,"VolStats_Title",OBJPROP_FONTSIZE,临_in_5); 
 ObjectSetInteger(0,"VolStats_Title",OBJPROP_COLOR,临_ui_4); 
 子_23_in=StatsPanelY + 32;
 子_24_in = (总_155_bo_C62) ?16:18  ;
 if ( 总_242_do_E40<=0.0 )
 {
   临_ui_10 = 总_130_ui_BD8;
 }
 else
 {
   临_do_11 = 子_3_do / 总_242_do_E40;
   if ( 临_do_11<0.6 )
   {
     临_ui_10 = 总_129_ui_BD4;
   }
   else
   {
     if ( 临_do_11<1.0 )
     {
       临_ui_10 = 总_130_ui_BD8;
     }
     else
     {
       if ( 临_do_11<1.5 )
       {
         临_ui_10 = 总_131_ui_BDC;
       }
       else
       {
         临_ui_10 = 总_132_ui_BE0;
       }
     }
   }
 }
 子_25_ui = 临_ui_10 ;
 子_26_st = "" ;
 if ( 子_3_do>总_242_do_E40 * 1.5 )
 {
   子_26_st = " ^^" ;
 }
 else
 {
   if ( 子_3_do>总_242_do_E40 )
   {
     子_26_st = " ^" ;
   }
   else
   {
     if ( 子_3_do<总_242_do_E40 * 0.5 )
     {
       子_26_st = " vv" ;
     }
     else
     {
       if ( 子_3_do<总_242_do_E40 )
       {
         子_26_st = " v" ;
       }
     }
   }
 }
 临_bo_12 = true;
 临_ui_13 = 子_25_ui;
 临_in_14 = 9;
 临_in_15 = 子_23_in;
 临_in_16 = StatsPanelX + 8;
 临_st_17 = "当前: " + DoubleToString(子_3_do,0) + " 点" + 子_26_st;
 if ( ObjectFind("VolStats_Current") == -1 )
 {
   ObjectCreate(0,"VolStats_Current",OBJ_LABEL,0,0,0.0); 
   ObjectSetInteger(0,"VolStats_Current",OBJPROP_CORNER,0); 
   ObjectSetInteger(0,"VolStats_Current",OBJPROP_ANCHOR,0); 
   ObjectSetInteger(0,"VolStats_Current",OBJPROP_SELECTABLE,0); 
 }
 ObjectSetInteger(0,"VolStats_Current",OBJPROP_XDISTANCE,临_in_16); 
 ObjectSetInteger(0,"VolStats_Current",OBJPROP_YDISTANCE,临_in_15); 
 ObjectSetString(0,"VolStats_Current",OBJPROP_TEXT,临_st_17); 
 if ( 临_bo_12 )
 {
   临_st_18 = "Arial Bold";
 }
 else
 {
   临_st_18 = "Arial";
 }
 ObjectSetString(0,"VolStats_Current",OBJPROP_FONT,临_st_18); 
 ObjectSetInteger(0,"VolStats_Current",OBJPROP_FONTSIZE,临_in_14); 
 ObjectSetInteger(0,"VolStats_Current",OBJPROP_COLOR,临_ui_13); 
 子_23_in +=子_24_in;
 if ( !(总_155_bo_C62) )
 {
   临_bo_19 = false;
   switch(2)
   {
     case 1 :
     临_ui_20 = White;
       break;
     case 2 :
     临_ui_20 = 0xD2CDC8;
       break;
     case 3 :
     临_ui_20 = 0xA0968C;
       break;
     default :
     临_ui_20 = 0xBEB9B4;
   }
   临_ui_21 = 临_ui_20;
   临_in_22 = 8;
   临_in_23 = 子_23_in;
   临_in_24 = StatsPanelX + 8;
   临_st_25 = "均值: " + DoubleToString(总_242_do_E40,0) + " 点";
   if ( ObjectFind("VolStats_Avg") == -1 )
   {
     ObjectCreate(0,"VolStats_Avg",OBJ_LABEL,0,0,0.0); 
     ObjectSetInteger(0,"VolStats_Avg",OBJPROP_CORNER,0); 
     ObjectSetInteger(0,"VolStats_Avg",OBJPROP_ANCHOR,0); 
     ObjectSetInteger(0,"VolStats_Avg",OBJPROP_SELECTABLE,0); 
   }
   ObjectSetInteger(0,"VolStats_Avg",OBJPROP_XDISTANCE,临_in_24); 
   ObjectSetInteger(0,"VolStats_Avg",OBJPROP_YDISTANCE,临_in_23); 
   ObjectSetString(0,"VolStats_Avg",OBJPROP_TEXT,临_st_25); 
   if ( 临_bo_19 )
   {
     临_st_26 = "Arial Bold";
   }
   else
   {
     临_st_26 = "Arial";
   }
   ObjectSetString(0,"VolStats_Avg",OBJPROP_FONT,临_st_26); 
   ObjectSetInteger(0,"VolStats_Avg",OBJPROP_FONTSIZE,临_in_22); 
   ObjectSetInteger(0,"VolStats_Avg",OBJPROP_COLOR,临_ui_21); 
   子_23_in +=子_24_in;
   临_bo_27 = false;
   switch(3)
   {
     case 1 :
     临_ui_28 = White;
       break;
     case 2 :
     临_ui_28 = 0xD2CDC8;
       break;
     case 3 :
     临_ui_28 = 0xA0968C;
       break;
     default :
     临_ui_28 = 0xBEB9B4;
   }
   临_ui_29 = 临_ui_28;
   临_in_30 = 8;
   临_in_31 = 子_23_in;
   临_in_32 = StatsPanelX + 8;
   临_st_33 = "区间: " + DoubleToString(总_241_do_E38,0) + " - " + DoubleToString(总_240_do_E30,0);
   if ( ObjectFind("VolStats_Range") == -1 )
   {
     ObjectCreate(0,"VolStats_Range",OBJ_LABEL,0,0,0.0); 
     ObjectSetInteger(0,"VolStats_Range",OBJPROP_CORNER,0); 
     ObjectSetInteger(0,"VolStats_Range",OBJPROP_ANCHOR,0); 
     ObjectSetInteger(0,"VolStats_Range",OBJPROP_SELECTABLE,0); 
   }
   ObjectSetInteger(0,"VolStats_Range",OBJPROP_XDISTANCE,临_in_32); 
   ObjectSetInteger(0,"VolStats_Range",OBJPROP_YDISTANCE,临_in_31); 
   ObjectSetString(0,"VolStats_Range",OBJPROP_TEXT,临_st_33); 
   if ( 临_bo_27 )
   {
     临_st_34 = "Arial Bold";
   }
   else
   {
     临_st_34 = "Arial";
   }
   ObjectSetString(0,"VolStats_Range",OBJPROP_FONT,临_st_34); 
   ObjectSetInteger(0,"VolStats_Range",OBJPROP_FONTSIZE,临_in_30); 
   ObjectSetInteger(0,"VolStats_Range",OBJPROP_COLOR,临_ui_29); 
   子_23_in +=子_24_in;
 }
 子_27_st = "" ;
 子_28_ui = Gray ;
 子_29_st = "" ;
 if ( 子_6_do>=85.0 )
 {
   子_27_st = "极高波动 [" + DoubleToString(子_6_do,0) + "%]" ;
   子_28_ui = Red ;
   子_29_st = " !!!" ;
 }
 else
 {
   if ( 子_6_do>=65.0 )
   {
     子_27_st = "高波动 [" + DoubleToString(子_6_do,0) + "%]" ;
     子_28_ui = Orange ;
     子_29_st = " !!" ;
   }
   else
   {
     if ( 子_6_do>=35.0 )
     {
       子_27_st = "中等波动 [" + DoubleToString(子_6_do,0) + "%]" ;
       子_28_ui = Goldenrod ;
       子_29_st = " =" ;
     }
     else
     {
       if ( 子_6_do>=15.0 )
       {
         子_27_st = "低波动 [" + DoubleToString(子_6_do,0) + "%]" ;
         子_28_ui = Gray ;
         子_29_st = " -" ;
       }
       else
       {
         子_27_st = "极低波动 [" + DoubleToString(子_6_do,0) + "%]" ;
         子_28_ui = DimGray ;
         子_29_st = " ." ;
       }
     }
   }
 }
 临_bo_35 = true;
 临_ui_36 = 子_28_ui;
 临_in_37 = 9;
 临_in_38 = 子_23_in;
 临_in_39 = StatsPanelX + 8;
 临_st_40 = "等级: " + 子_27_st + 子_29_st;
 if ( ObjectFind("VolStats_Rank") == -1 )
 {
   ObjectCreate(0,"VolStats_Rank",OBJ_LABEL,0,0,0.0); 
   ObjectSetInteger(0,"VolStats_Rank",OBJPROP_CORNER,0); 
   ObjectSetInteger(0,"VolStats_Rank",OBJPROP_ANCHOR,0); 
   ObjectSetInteger(0,"VolStats_Rank",OBJPROP_SELECTABLE,0); 
 }
 ObjectSetInteger(0,"VolStats_Rank",OBJPROP_XDISTANCE,临_in_39); 
 ObjectSetInteger(0,"VolStats_Rank",OBJPROP_YDISTANCE,临_in_38); 
 ObjectSetString(0,"VolStats_Rank",OBJPROP_TEXT,临_st_40); 
 if ( 临_bo_35 )
 {
   临_st_41 = "Arial Bold";
 }
 else
 {
   临_st_41 = "Arial";
 }
 ObjectSetString(0,"VolStats_Rank",OBJPROP_FONT,临_st_41); 
 ObjectSetInteger(0,"VolStats_Rank",OBJPROP_FONTSIZE,临_in_37); 
 ObjectSetInteger(0,"VolStats_Rank",OBJPROP_COLOR,临_ui_36); 
 子_23_in +=子_24_in;
 if ( 总_139_bo_C08 )
 {
   lizong_38(StatsPanelX + 8,子_23_in,子_11_in - 16,子_6_do); 
   子_23_in +=16;
 }
 if ( 总_145_bo_C34 )
 {
   lizong_37(StatsPanelX + 8,子_23_in,子_11_in - 16,20); 
   子_23_in +=20;
 }
 if ( 总_147_bo_C3C )
 {
   子_30_st = "加速度: " ;
   子_31_ui = Gray ;
   子_32_st = "" ;
   if ( 总_246_do_F28>30.0 )
   {
     子_30_st="加速度: " + ("+" + DoubleToString(总_246_do_F28,0) + "%");
     子_31_ui = Orange ;
     子_32_st = " ↑↑ 快速放大" ;
   }
   else
   {
     if ( 总_246_do_F28>10.0 )
     {
       子_30_st +="+" + DoubleToString(总_246_do_F28,0) + "%";
       子_31_ui = Goldenrod ;
       子_32_st = " ↗ 放大中" ;
     }
     else
     {
       if ( 总_246_do_F28<-30.0 )
       {
         子_30_st +=DoubleToString(总_246_do_F28,0) + "%";
         子_31_ui = DodgerBlue ;
         子_32_st = " ↓↓ 快速缩小" ;
       }
       else
       {
         if ( 总_246_do_F28<-10.0 )
         {
           子_30_st +=DoubleToString(总_246_do_F28,0) + "%";
           子_31_ui = LightSteelBlue ;
           子_32_st = " ↘ 缩小中" ;
         }
         else
         {
           子_30_st +=DoubleToString(总_246_do_F28,0) + "%";
           子_32_st = " → 稳定" ;
         }
       }
     }
   }
   if ( 总_155_bo_C62 )
   {
     子_32_st = "" ;
   }
   临_bo_42 = false;
   临_ui_43 = 子_31_ui;
   临_in_44 = 8;
   临_in_45 = 子_23_in;
   临_in_46 = StatsPanelX + 8;
   临_st_47 = 子_30_st + 子_32_st;
   if ( ObjectFind("VolStats_Accel") == -1 )
   {
     ObjectCreate(0,"VolStats_Accel",OBJ_LABEL,0,0,0.0); 
     ObjectSetInteger(0,"VolStats_Accel",OBJPROP_CORNER,0); 
     ObjectSetInteger(0,"VolStats_Accel",OBJPROP_ANCHOR,0); 
     ObjectSetInteger(0,"VolStats_Accel",OBJPROP_SELECTABLE,0); 
   }
   ObjectSetInteger(0,"VolStats_Accel",OBJPROP_XDISTANCE,临_in_46); 
   ObjectSetInteger(0,"VolStats_Accel",OBJPROP_YDISTANCE,临_in_45); 
   ObjectSetString(0,"VolStats_Accel",OBJPROP_TEXT,临_st_47); 
   if ( 临_bo_42 )
   {
     临_st_48 = "Arial Bold";
   }
   else
   {
     临_st_48 = "Arial";
   }
   ObjectSetString(0,"VolStats_Accel",OBJPROP_FONT,临_st_48); 
   ObjectSetInteger(0,"VolStats_Accel",OBJPROP_FONTSIZE,临_in_44); 
   ObjectSetInteger(0,"VolStats_Accel",OBJPROP_COLOR,临_ui_43); 
   子_23_in +=子_24_in;
 }
 if ( 总_148_bo_C3D && 总_248_do_F38>0.0 )
 {
   子_33_st = "预测: " + DoubleToString(总_247_do_F30,0) + "-" + DoubleToString(总_248_do_F38,0) + " 点" ;
   临_bo_49 = false;
   临_ui_50 = 0xDC8CB4;
   临_in_51 = 8;
   临_in_52 = 子_23_in;
   临_in_53 = StatsPanelX + 8;
   临_st_54 = 子_33_st;
   if ( ObjectFind("VolStats_Predict") == -1 )
   {
     ObjectCreate(0,"VolStats_Predict",OBJ_LABEL,0,0,0.0); 
     ObjectSetInteger(0,"VolStats_Predict",OBJPROP_CORNER,0); 
     ObjectSetInteger(0,"VolStats_Predict",OBJPROP_ANCHOR,0); 
     ObjectSetInteger(0,"VolStats_Predict",OBJPROP_SELECTABLE,0); 
   }
   ObjectSetInteger(0,"VolStats_Predict",OBJPROP_XDISTANCE,临_in_53); 
   ObjectSetInteger(0,"VolStats_Predict",OBJPROP_YDISTANCE,临_in_52); 
   ObjectSetString(0,"VolStats_Predict",OBJPROP_TEXT,临_st_54); 
   if ( 临_bo_49 )
   {
     临_st_55 = "Arial Bold";
   }
   else
   {
     临_st_55 = "Arial";
   }
   ObjectSetString(0,"VolStats_Predict",OBJPROP_FONT,临_st_55); 
   ObjectSetInteger(0,"VolStats_Predict",OBJPROP_FONTSIZE,临_in_51); 
   ObjectSetInteger(0,"VolStats_Predict",OBJPROP_COLOR,临_ui_50); 
   子_23_in +=子_24_in;
 }
 if ( 总_151_bo_C54 )
 {
   子_34_st = "建议止损: " + DoubleToString(总_249_do_F40,0) + " 点" ;
   临_bo_56 = false;
   临_ui_57 = 0x5050DC;
   临_in_58 = 8;
   临_in_59 = 子_23_in;
   临_in_60 = StatsPanelX + 8;
   临_st_61 = 子_34_st;
   if ( ObjectFind("VolStats_StopLoss") == -1 )
   {
     ObjectCreate(0,"VolStats_StopLoss",OBJ_LABEL,0,0,0.0); 
     ObjectSetInteger(0,"VolStats_StopLoss",OBJPROP_CORNER,0); 
     ObjectSetInteger(0,"VolStats_StopLoss",OBJPROP_ANCHOR,0); 
     ObjectSetInteger(0,"VolStats_StopLoss",OBJPROP_SELECTABLE,0); 
   }
   ObjectSetInteger(0,"VolStats_StopLoss",OBJPROP_XDISTANCE,临_in_60); 
   ObjectSetInteger(0,"VolStats_StopLoss",OBJPROP_YDISTANCE,临_in_59); 
   ObjectSetString(0,"VolStats_StopLoss",OBJPROP_TEXT,临_st_61); 
   if ( 临_bo_56 )
   {
     临_st_62 = "Arial Bold";
   }
   else
   {
     临_st_62 = "Arial";
   }
   ObjectSetString(0,"VolStats_StopLoss",OBJPROP_FONT,临_st_62); 
   ObjectSetInteger(0,"VolStats_StopLoss",OBJPROP_FONTSIZE,临_in_58); 
   ObjectSetInteger(0,"VolStats_StopLoss",OBJPROP_COLOR,临_ui_57); 
   子_23_in +=子_24_in;
 }
 if ( 总_153_bo_C60 )
 {
   子_35_st = "仓位建议: " ;
   if ( 总_250_do_F48>=1.0 )
   {
     子_35_st = "仓位建议: 标准 (100%)" ;
   }
   else
   {
     if ( 总_250_do_F48>=0.8 )
     {
       子_35_st +="减仓 (80%)";
     }
     else
     {
       if ( 总_250_do_F48>=0.5 )
       {
         子_35_st +="半仓 (50%)";
       }
       else
       {
         子_35_st +="小仓 (30%)";
       }
     }
   }
   子_36_ui = (总_250_do_F48>=0.8) ?0x78C864:0x64B4FF  ;
   临_bo_63 = false;
   临_ui_64 = 子_36_ui;
   临_in_65 = 8;
   临_in_66 = 子_23_in;
   临_in_67 = StatsPanelX + 8;
   临_st_68 = 子_35_st;
   if ( ObjectFind("VolStats_Position") == -1 )
   {
     ObjectCreate(0,"VolStats_Position",OBJ_LABEL,0,0,0.0); 
     ObjectSetInteger(0,"VolStats_Position",OBJPROP_CORNER,0); 
     ObjectSetInteger(0,"VolStats_Position",OBJPROP_ANCHOR,0); 
     ObjectSetInteger(0,"VolStats_Position",OBJPROP_SELECTABLE,0); 
   }
   ObjectSetInteger(0,"VolStats_Position",OBJPROP_XDISTANCE,临_in_67); 
   ObjectSetInteger(0,"VolStats_Position",OBJPROP_YDISTANCE,临_in_66); 
   ObjectSetString(0,"VolStats_Position",OBJPROP_TEXT,临_st_68); 
   if ( 临_bo_63 )
   {
     临_st_69 = "Arial Bold";
   }
   else
   {
     临_st_69 = "Arial";
   }
   ObjectSetString(0,"VolStats_Position",OBJPROP_FONT,临_st_69); 
   ObjectSetInteger(0,"VolStats_Position",OBJPROP_FONTSIZE,临_in_65); 
   ObjectSetInteger(0,"VolStats_Position",OBJPROP_COLOR,临_ui_64); 
   子_23_in +=子_24_in;
 }
 if ( 总_154_bo_C61 )
 {
   子_37_st = "风险评分: " + IntegerToString(总_251_in_F50,0,32) + "/10" ;
   子_38_st = " [" ;
   for (子_39_in = 1 ; 子_39_in <= 10 ; 子_39_in ++)
   {
     if ( 子_39_in <= 总_251_in_F50 )
     {
       子_38_st +="|";
        continue;
     }
     子_38_st +=".";
     
   }
   子_38_st +="]";
   switch(2)
   {
     case 1 :
     临_ui_70 = White;
       break;
     case 2 :
     临_ui_70 = 0xD2CDC8;
       break;
     case 3 :
     临_ui_70 = 0xA0968C;
       break;
     default :
     临_ui_70 = 0xBEB9B4;
   }
   子_40_ui = 临_ui_70 ;
   if ( 总_251_in_F50 >= 8 )
   {
     子_40_ui = 0x5050DC ;
   }
   else
   {
     if ( 总_251_in_F50 >= 6 )
     {
       子_40_ui = 0x508CFF ;
     }
     else
     {
       if ( 总_251_in_F50 >= 4 )
       {
         子_40_ui = 0x64C8FF ;
       }
       else
       {
         子_40_ui = 0x78C864 ;
       }
     }
   }
   if ( 总_155_bo_C62 )
   {
     临_bo_71 = false;
     临_ui_72 = 子_40_ui;
     临_in_73 = 8;
     临_in_74 = 子_23_in;
     临_in_75 = StatsPanelX + 8;
     临_st_76 = 子_37_st;
     if ( ObjectFind("VolStats_Risk") == -1 )
     {
       ObjectCreate(0,"VolStats_Risk",OBJ_LABEL,0,0,0.0); 
       ObjectSetInteger(0,"VolStats_Risk",OBJPROP_CORNER,0); 
       ObjectSetInteger(0,"VolStats_Risk",OBJPROP_ANCHOR,0); 
       ObjectSetInteger(0,"VolStats_Risk",OBJPROP_SELECTABLE,0); 
     }
     ObjectSetInteger(0,"VolStats_Risk",OBJPROP_XDISTANCE,临_in_75); 
     ObjectSetInteger(0,"VolStats_Risk",OBJPROP_YDISTANCE,临_in_74); 
     ObjectSetString(0,"VolStats_Risk",OBJPROP_TEXT,临_st_76); 
     if ( 临_bo_71 )
     {
       临_st_77 = "Arial Bold";
     }
     else
     {
       临_st_77 = "Arial";
     }
     ObjectSetString(0,"VolStats_Risk",OBJPROP_FONT,临_st_77); 
     ObjectSetInteger(0,"VolStats_Risk",OBJPROP_FONTSIZE,临_in_73); 
     ObjectSetInteger(0,"VolStats_Risk",OBJPROP_COLOR,临_ui_72); 
   }
   else
   {
     临_bo_78 = false;
     临_ui_79 = 子_40_ui;
     临_in_80 = 7;
     临_in_81 = 子_23_in;
     临_in_82 = StatsPanelX + 8;
     临_st_83 = 子_37_st + 子_38_st;
     if ( ObjectFind("VolStats_Risk") == -1 )
     {
       ObjectCreate(0,"VolStats_Risk",OBJ_LABEL,0,0,0.0); 
       ObjectSetInteger(0,"VolStats_Risk",OBJPROP_CORNER,0); 
       ObjectSetInteger(0,"VolStats_Risk",OBJPROP_ANCHOR,0); 
       ObjectSetInteger(0,"VolStats_Risk",OBJPROP_SELECTABLE,0); 
     }
     ObjectSetInteger(0,"VolStats_Risk",OBJPROP_XDISTANCE,临_in_82); 
     ObjectSetInteger(0,"VolStats_Risk",OBJPROP_YDISTANCE,临_in_81); 
     ObjectSetString(0,"VolStats_Risk",OBJPROP_TEXT,临_st_83); 
     if ( 临_bo_78 )
     {
       临_st_84 = "Arial Bold";
     }
     else
     {
       临_st_84 = "Arial";
     }
     ObjectSetString(0,"VolStats_Risk",OBJPROP_FONT,临_st_84); 
     ObjectSetInteger(0,"VolStats_Risk",OBJPROP_FONTSIZE,临_in_80); 
     ObjectSetInteger(0,"VolStats_Risk",OBJPROP_COLOR,临_ui_79); 
   }
   子_23_in +=子_24_in;
 }
 if ( 总_125_bo_BB7 && !(总_155_bo_C62) )
 {
   子_41_st = lizong_35(子_3_do,总_242_do_E40,总_240_do_E30,子_6_do) ;
   if ( 总_242_do_E40<=0.0 )
   {
     临_ui_85 = Gray;
   }
   else
   {
     临_do_86 = 子_3_do / 总_242_do_E40;
     if ( 临_do_86<0.7 )
     {
       临_ui_85 = DimGray;
     }
     else
     {
       if ( 临_do_86<1.2 )
       {
         临_ui_85 = Green;
       }
       else
       {
         if ( 临_do_86<1.8 )
         {
           临_ui_85 = Orange;
         }
         else
         {
           临_ui_85 = Red;
         }
       }
     }
   }
   子_42_ui = 临_ui_85 ;
   临_bo_87 = false;
   临_ui_88 = 子_42_ui;
   临_in_89 = 8;
   临_in_90 = 子_23_in;
   临_in_91 = StatsPanelX + 8;
   临_st_92 = 子_41_st;
   if ( ObjectFind("VolStats_Advice") == -1 )
   {
     ObjectCreate(0,"VolStats_Advice",OBJ_LABEL,0,0,0.0); 
     ObjectSetInteger(0,"VolStats_Advice",OBJPROP_CORNER,0); 
     ObjectSetInteger(0,"VolStats_Advice",OBJPROP_ANCHOR,0); 
     ObjectSetInteger(0,"VolStats_Advice",OBJPROP_SELECTABLE,0); 
   }
   ObjectSetInteger(0,"VolStats_Advice",OBJPROP_XDISTANCE,临_in_91); 
   ObjectSetInteger(0,"VolStats_Advice",OBJPROP_YDISTANCE,临_in_90); 
   ObjectSetString(0,"VolStats_Advice",OBJPROP_TEXT,临_st_92); 
   if ( 临_bo_87 )
   {
     临_st_93 = "Arial Bold";
   }
   else
   {
     临_st_93 = "Arial";
   }
   ObjectSetString(0,"VolStats_Advice",OBJPROP_FONT,临_st_93); 
   ObjectSetInteger(0,"VolStats_Advice",OBJPROP_FONTSIZE,临_in_89); 
   ObjectSetInteger(0,"VolStats_Advice",OBJPROP_COLOR,临_ui_88); 
 }
 if ( 总_140_bo_C09 && ObjectFind(子_13_st) != -1 )
 {
   if ( 子_6_do>=85.0 )
   {
     if ( 总_252_in_F54 == 0 )
     {
       总_252_in_F54 = 1 ;
       总_253_da_F58 = TimeCurrent() ;
     }
   }
   else
   {
     总_252_in_F54 = 0 ;
     ObjectSetInteger(0,子_13_st,OBJPROP_BORDER_COLOR,0x808080); 
   }
 }
 }
//lizong_34 <<==--------   --------
 string lizong_35( double 木_0_do,double 木_1_do,double 木_2_do,double 木_3_do)
 {
  double    子_1_do;
  double    子_2_do;
//----- -----
 double     临_do_1;

 if ( 木_1_do<=0.0 )
 {
   return("数据不足,等待");
 }
 子_1_do = 木_0_do / 木_1_do ;
 if ( 木_2_do>0.0 )
 {
   临_do_1 = 木_0_do / 木_2_do;
 }
 else
 {
   临_do_1 = 0.0;
 }
 子_2_do = 临_do_1 ;
 if ( 子_1_do<0.5 )
 {
   return("建议:等待波动放大");
 }
 if ( 子_1_do<0.7 )
 {
   return("建议:观望或小仓试探");
 }
 if ( 子_1_do>=0.8 && 子_1_do<=1.2 )
 {
   return("建议:正常波动,可交易");
 }
 if ( 子_1_do>1.2 && 子_1_do<=1.8 )
 {
   if ( 木_3_do>70.0 )
   {
     return("机会:趋势强劲,顺势追");
   }
   return("建议:高波动,激进交易");
 }
 if ( 子_1_do>1.8 )
 {
   if ( 子_2_do>0.85 )
   {
     return("警告:波动极端,注意反转");
   }
   return("机会:重大行情,快速跟进");
 }
 return("建议:观察中");
 }
//lizong_35 <<==--------   --------
 void lizong_36()
 {
  double    子_1_do = 0.0;
  double    子_2_do;
  double    子_3_do;
  datetime  子_4_da;
  string    子_5_st;
  double    子_6_do;
  string    子_7_st;
//----- -----

 if ( !(总_126_bo_BB8) || !(总_233_bo_E00) )   return;
 
 if ( iBars(NULL,总_234_in_E04) >  0 )
 {
   子_2_do = iHigh(NULL,总_234_in_E04,0) ;
   子_3_do = iLow(NULL,总_234_in_E04,0) ;
   if ( 子_2_do>0.0 && 子_3_do>0.0 && Point>0.0 )
   {
     子_1_do = (子_2_do - 子_3_do) / Point ;
   }
 }
 if ( !(总_242_do_E40>0.0) || !(子_1_do>总_242_do_E40 * 总_127_do_BC0) )   return;
 子_4_da = iTime(NULL,总_234_in_E04,0) ;
 if ( 总_243_lo_E48 == 子_4_da )   return;
 总_243_lo_E48 = 子_4_da ;
 子_5_st = lizong_39(总_234_in_E04) ;
 子_6_do = 子_1_do / 总_242_do_E40 ;
 子_7_st = StringFormat("【波动预警】%s %s 波动异常放大！\n━━━━━━━━━━━━━━━━\n当前波动: %.0f 点\n平均波动: %.0f 点\n放大倍数: %.1f 倍\n━━━━━━━━━━━━━━━━\n建议: 关注重大行情机会！",Symbol(),子_5_st,子_1_do,总_242_do_E40,子_6_do) ;
 if ( AlertWithSound )
 {
   Alert(子_7_st); 
 }
 else
 {
   Print(子_7_st); 
 }
 if ( ObjectFind("VolWarning_Flash") == -1 )
 {
   ObjectCreate(0,"VolWarning_Flash",OBJ_LABEL,0,0,0.0); 
   ObjectSetInteger(0,"VolWarning_Flash",OBJPROP_CORNER,0); 
   ObjectSetInteger(0,"VolWarning_Flash",OBJPROP_ANCHOR,0); 
   ObjectSetInteger(0,"VolWarning_Flash",OBJPROP_SELECTABLE,0); 
 }
 ObjectSetInteger(0,"VolWarning_Flash",OBJPROP_XDISTANCE,0xFA); 
 ObjectSetInteger(0,"VolWarning_Flash",OBJPROP_YDISTANCE,0x1E); 
 ObjectSetString(0,"VolWarning_Flash",OBJPROP_TEXT," 波动异常放大 "); 
 ObjectSetInteger(0,"VolWarning_Flash",OBJPROP_FONTSIZE,0xE); 
 ObjectSetInteger(0,"VolWarning_Flash",OBJPROP_COLOR,0xFF); 
 ObjectSetString(0,"VolWarning_Flash",OBJPROP_FONT,"Arial Black"); 
 ObjectSetInteger(0,"VolWarning_Flash",OBJPROP_TIME,TimeCurrent()); 
 }
//lizong_36 <<==--------   --------
 void lizong_37( int 木_0_in,int 木_1_in,int 木_in_2,int 木_3_in)
 {
  int       子_1_in;
  string    子_2_st;
  double    子_3_do;
  double    子_4_do;
  int       子_5_in;
  double    子_6_do;
  string    子_7_st;
  uint      子_8_ui;
  double    子_9_do;
  double    子_10_do;
  double    子_11_do;
//----- -----
 bool       临_bo_1;
 uint       临_ui_2;
 int        临_in_3;
 int        临_in_4;
 int        临_in_5;
 string     临_st_6;
 string     临_st_7;
 bool       临_bo_8;
 uint       临_ui_9;
 int        临_in_10;
 int        临_in_11;
 int        临_in_12;
 string     临_st_13;
 string     临_st_14;

 if ( !(总_145_bo_C34) || 总_245_in_F24 < 2 )   return;
 for (子_1_in = 0 ; 子_1_in < 20 ; 子_1_in ++)
 {
   子_2_st="VolTrend_Line_" + IntegerToString(子_1_in,0,32);
   if ( ObjectFind(子_2_st) != -1 )
   {
     ObjectDelete(子_2_st); 
   }
 }
 if ( ( 总_245_in_F24 <= 0 || 总_245_in_F24 >  20 ) )
 {
   Print("错误：波动历史数组大小异常 g_VolHistoryCount=",总_245_in_F24); 
   return;
 }
 子_3_do = 总_244_do_E84_si20[0] ;
 子_4_do = 总_244_do_E84_si20[0] ;
 for (子_5_in = 1 ; 子_5_in < 总_245_in_F24 ; 子_5_in ++)
 {
   子_3_do = MathMax(子_3_do,总_244_do_E84_si20[子_5_in]) ;
   子_4_do = MathMin(子_4_do,总_244_do_E84_si20[子_5_in]) ;
 }
 子_6_do = 子_3_do - 子_4_do ;
 if ( 子_6_do<1.0 )
 {
   子_6_do = 1.0 ;
 }
 子_7_st = "" ;
 子_8_ui = Aqua ;
 if ( 总_245_in_F24 >= 3 )
 {
   子_9_do = (总_244_do_E84_si20[0] + 总_244_do_E84_si20[1]) / 2.0 ;
   子_10_do = (总_244_do_E84_si20[总_245_in_F24 - 1] + 总_244_do_E84_si20[总_245_in_F24 - 2]) / 2.0 ;
   if ( 子_10_do<=0.001 )
   {
     子_7_st = "数据异常" ;
     子_8_ui = Gray ;
     临_bo_1 = false;
     临_ui_2 = Gray;
     临_in_3 = 9;
     临_in_4 = 木_1_in;
     临_in_5 = 木_0_in;
     临_st_6 = "趋势: 数据异常";
     if ( ObjectFind("VolTrend_Chart") == -1 )
     {
       ObjectCreate(0,"VolTrend_Chart",OBJ_LABEL,0,0,0.0); 
       ObjectSetInteger(0,"VolTrend_Chart",OBJPROP_CORNER,0); 
       ObjectSetInteger(0,"VolTrend_Chart",OBJPROP_ANCHOR,0); 
       ObjectSetInteger(0,"VolTrend_Chart",OBJPROP_SELECTABLE,0); 
     }
     ObjectSetInteger(0,"VolTrend_Chart",OBJPROP_XDISTANCE,临_in_5); 
     ObjectSetInteger(0,"VolTrend_Chart",OBJPROP_YDISTANCE,临_in_4); 
     ObjectSetString(0,"VolTrend_Chart",OBJPROP_TEXT,临_st_6); 
     if ( 临_bo_1 )
     {
       临_st_7 = "Arial Bold";
     }
     else
     {
       临_st_7 = "Arial";
     }
     ObjectSetString(0,"VolTrend_Chart",OBJPROP_FONT,临_st_7); 
     ObjectSetInteger(0,"VolTrend_Chart",OBJPROP_FONTSIZE,临_in_3); 
     ObjectSetInteger(0,"VolTrend_Chart",OBJPROP_COLOR,临_ui_2); 
     return;
   }
   子_11_do = (子_9_do - 子_10_do) / 子_10_do * 100.0 ;
   if ( 子_9_do>子_10_do * 1.3 )
   {
     子_7_st = "快速上升 (" + DoubleToString(子_11_do,0) + "%)" ;
     子_8_ui = Lime ;
   }
   else
   {
     if ( 子_9_do>子_10_do * 1.15 )
     {
       子_7_st = "上升 (" + DoubleToString(子_11_do,0) + "%)" ;
       子_8_ui = 0x78C864 ;
     }
     else
     {
       if ( 子_9_do<子_10_do * 0.7 )
       {
         子_7_st = "快速下降 (" + DoubleToString(子_11_do,0) + "%)" ;
         子_8_ui = Orange ;
       }
       else
       {
         if ( 子_9_do<子_10_do * 0.85 )
         {
           子_7_st = "下降 (" + DoubleToString(子_11_do,0) + "%)" ;
           子_8_ui = 0x64B4FF ;
         }
         else
         {
           子_7_st = "平稳 (" + DoubleToString(子_11_do,0) + "%)" ;
           子_8_ui = 0xA0968C ;
         }
       }
     }
   }
 }
 else
 {
   子_7_st = "数据不足" ;
   子_8_ui = Gray ;
 }
 临_bo_8 = false;
 临_ui_9 = 子_8_ui;
 临_in_10 = 9;
 临_in_11 = 木_1_in;
 临_in_12 = 木_0_in;
 临_st_13 = "趋势: " + 子_7_st;
 if ( ObjectFind("VolTrend_Chart") == -1 )
 {
   ObjectCreate(0,"VolTrend_Chart",OBJ_LABEL,0,0,0.0); 
   ObjectSetInteger(0,"VolTrend_Chart",OBJPROP_CORNER,0); 
   ObjectSetInteger(0,"VolTrend_Chart",OBJPROP_ANCHOR,0); 
   ObjectSetInteger(0,"VolTrend_Chart",OBJPROP_SELECTABLE,0); 
 }
 ObjectSetInteger(0,"VolTrend_Chart",OBJPROP_XDISTANCE,临_in_12); 
 ObjectSetInteger(0,"VolTrend_Chart",OBJPROP_YDISTANCE,临_in_11); 
 ObjectSetString(0,"VolTrend_Chart",OBJPROP_TEXT,临_st_13); 
 if ( 临_bo_8 )
 {
   临_st_14 = "Arial Bold";
 }
 else
 {
   临_st_14 = "Arial";
 }
 ObjectSetString(0,"VolTrend_Chart",OBJPROP_FONT,临_st_14); 
 ObjectSetInteger(0,"VolTrend_Chart",OBJPROP_FONTSIZE,临_in_10); 
 ObjectSetInteger(0,"VolTrend_Chart",OBJPROP_COLOR,临_ui_9); 
 }
//lizong_37 <<==--------   --------
 void lizong_38( int 木_0_in,int 木_1_in,int 木_2_in,double 木_3_do)
 {
  string    子_1_st;
  string    子_2_st;
  int       子_3_in;
  uint      子_4_ui;
//----- -----

 if ( !(总_139_bo_C08) )   return;
 子_1_st = "VolProgress_BG" ;
 if ( ObjectFind(子_1_st) == -1 )
 {
   ObjectCreate(0,子_1_st,OBJ_RECTANGLE_LABEL,0,0,0.0); 
   ObjectSetInteger(0,子_1_st,OBJPROP_CORNER,0); 
   ObjectSetInteger(0,子_1_st,OBJPROP_BGCOLOR,0xA9A9A9); 
   ObjectSetInteger(0,子_1_st,OBJPROP_BORDER_TYPE,0); 
   ObjectSetInteger(0,子_1_st,OBJPROP_SELECTABLE,0); 
 }
 ObjectSetInteger(0,子_1_st,OBJPROP_XDISTANCE,木_0_in); 
 ObjectSetInteger(0,子_1_st,OBJPROP_YDISTANCE,木_1_in); 
 ObjectSetInteger(0,子_1_st,OBJPROP_XSIZE,木_2_in); 
 ObjectSetInteger(0,子_1_st,OBJPROP_YSIZE,0x6); 
 子_2_st = "VolProgress_Bar" ;
 子_3_in=(int)(木_2_in * 木_3_do / 100.0);
 子_4_ui = LimeGreen ;
 if ( 木_3_do>=85.0 )
 {
   子_4_ui = Red ;
 }
 else
 {
   if ( 木_3_do>=65.0 )
   {
     子_4_ui = Orange ;
   }
   else
   {
     if ( 木_3_do>=35.0 )
     {
       子_4_ui = Yellow ;
     }
   }
 }
 if ( ObjectFind(子_2_st) == -1 )
 {
   ObjectCreate(0,子_2_st,OBJ_RECTANGLE_LABEL,0,0,0.0); 
   ObjectSetInteger(0,子_2_st,OBJPROP_CORNER,0); 
   ObjectSetInteger(0,子_2_st,OBJPROP_BORDER_TYPE,0); 
   ObjectSetInteger(0,子_2_st,OBJPROP_SELECTABLE,0); 
 }
 ObjectSetInteger(0,子_2_st,OBJPROP_XDISTANCE,木_0_in); 
 ObjectSetInteger(0,子_2_st,OBJPROP_YDISTANCE,木_1_in); 
 ObjectSetInteger(0,子_2_st,OBJPROP_XSIZE,子_3_in); 
 ObjectSetInteger(0,子_2_st,OBJPROP_YSIZE,0x6); 
 ObjectSetInteger(0,子_2_st,OBJPROP_BGCOLOR,子_4_ui); 
 }
//lizong_38 <<==--------   --------
 string lizong_39( int 木_0_in)
 {
 switch(木_0_in)
 {
   case 1 :
   return("M1");
   case 5 :
   return("M5");
   case 15 :
   return("M15");
   case 30 :
   return("M30");
   case 60 :
   return("H1");
   case 240 :
   return("H4");
   case 1440 :
   return("D1");
   case 10080 :
   return("W1");
   case 43200 :
   return("MN");
 }
 return("M" + IntegerToString(木_0_in,0,32));
 }
//lizong_39 <<==--------   --------
 int lizong_40( int 木_0_in)
 {
  double    子_2_do;
  double    子_3_do;
  double    子_4_do;
  double    子_5_do;
  double    子_6_do;
  double    子_7_do;
  int       子_8_in;
  double    子_9_do;
  double    子_10_do;
  double    子_11_do;
  double    子_12_do;
  double    子_13_do;
  double    子_14_do;
  double    子_15_do;
//----- -----
 double     临_do_1;
 double     临_do_2;
 double     临_do_3;
 double     临_do_4;
 double     临_do_5;

 子_2_do = iMA(NULL,0,总_56_in_A54,0,1,0,木_0_in) ;
 子_3_do = iMA(NULL,0,总_57_in_A58,0,1,0,木_0_in) ;
 子_4_do = iMA(NULL,0,总_62_in_A6C,0,1,0,木_0_in) ;
 子_5_do = iMA(NULL,0,总_63_in_A70,0,1,0,木_0_in) ;
 子_6_do = iClose(NULL,0,木_0_in) ;
 子_7_do = iATR(NULL,0,总_85_in_AF8,木_0_in) ;
 if ( ( 子_2_do<=0.0 || 子_3_do<=0.0 || 子_4_do<=0.0 || 子_5_do<=0.0 || 子_6_do<=0.0 ) )
 {
   return(0); 
 }
 if ( 子_7_do<=0.000001 )
 {
   if ( Point>0.0 )
   {
     临_do_1 = Point * 100.0;
   }
   else
   {
     临_do_1 = 0.00001;
   }
   子_7_do = 临_do_1 ;
 }
 if ( 子_7_do<=0.000001 )
 {
   return(0); 
 }
 子_8_in = 0 ;
 子_9_do = (子_2_do - 子_3_do) / 子_7_do ;
 if ( MathAbs(子_9_do)<1000.0 )
 {
   if ( (MathAbs(子_9_do)) * 30.0 >= 30 )
   {
     临_do_2 = 30.0;
   }
   else
   {
     临_do_2 = (MathAbs(子_9_do)) * 30.0;
   }
   子_8_in +=int(临_do_2 * ((子_9_do>0.0) ?1:-1 ));
 }
 子_10_do = (子_4_do - 子_5_do) / 子_7_do ;
 if ( MathAbs(子_10_do)<1000.0 )
 {
   if ( (MathAbs(子_10_do)) * 30.0 >= 30 )
   {
     临_do_3 = 30.0;
   }
   else
   {
     临_do_3 = (MathAbs(子_10_do)) * 30.0;
   }
   子_8_in +=int(临_do_3 * ((子_10_do>0.0) ?1:-1 ));
 }
 子_11_do = (子_2_do + 子_3_do + 子_4_do + 子_5_do) / 4.0 ;
 if ( 子_11_do>0.0 )
 {
   子_12_do = (子_6_do - 子_11_do) / 子_7_do ;
   if ( MathAbs(子_12_do)<1000.0 )
   {
     if ( (MathAbs(子_12_do)) * 20.0 >= 20 )
     {
       临_do_4 = 20.0;
     }
     else
     {
       临_do_4 = (MathAbs(子_12_do)) * 20.0;
     }
     子_8_in +=int(临_do_4 * ((子_12_do>0.0) ?1:-1 ));
   }
 }
 子_13_do = iOpen(NULL,0,木_0_in) ;
 子_14_do = 子_6_do - 子_13_do ;
 子_15_do = 子_14_do / 子_7_do * 20.0 ;
 if ( MathAbs(子_15_do)<1000.0 )
 {
   if ( 子_15_do <= -20 )
   {
     临_do_5 = -20.0;
   }
   else
   {
     临_do_5 = 子_15_do;
   }
   子_8_in +=int((临_do_5 >= 20) ?20.0:临_do_5 );
 }
 return(MathMin(MathMax(子_8_in,-100),100)); 
 }
//lizong_40 <<==--------   --------
 int lizong_41( int 木_0_in)
 {
  int       子_2_in;
  bool      子_3_bo;
  bool      子_4_bo;
  bool      子_5_bo;
  bool      子_6_bo;
  bool      子_7_bo;
  bool      子_8_bo;
  double    子_9_do;
  double    子_10_do;
  int       子_11_in;
  int       子_12_in;
  double    子_13_do;
//----- -----

 子_2_in = 50 ;
 子_3_bo=总_5_do_78_ko[木_0_in]>0.0;
 子_4_bo=总_6_do_AC_ko[木_0_in]>0.0;
 if ( !(子_3_bo) && !(子_4_bo) )
 {
   return(0); 
 }
 子_5_bo=总_23_do_420_ko[木_0_in]!=INT_MAX;
 子_6_bo=总_24_do_454_ko[木_0_in]!=INT_MAX;
 子_7_bo=总_27_do_4F0_ko[木_0_in]!=INT_MAX;
 子_8_bo=总_28_do_524_ko[木_0_in]!=INT_MAX;
 if ( 子_3_bo && 子_5_bo && 子_7_bo )
 {
   子_2_in +=20;
 }
 else
 {
   if ( 子_4_bo && 子_6_bo && 子_8_bo )
   {
     子_2_in +=20;
   }
 }
 if ( ( 总_37_do_6F8_ko[木_0_in]!=INT_MAX || 总_36_do_6C4_ko[木_0_in]!=INT_MAX ) )
 {
   子_2_in +=15;
 }
 else
 {
   if ( ( 总_40_do_794_ko[木_0_in]!=INT_MAX || 总_39_do_760_ko[木_0_in]!=INT_MAX ) )
   {
     子_2_in +=15;
   }
 }
 子_9_do = iATR(NULL,0,总_85_in_AF8,木_0_in) ;
 子_10_do = 0.0 ;
 子_11_in = 0 ;

 for (子_12_in = 0 ;总_85_in_AF8 >  0 && 木_0_in + 子_12_in < iBars(NULL,0) ; 子_12_in ++)
 {
   子_13_do = iATR(NULL,0,总_85_in_AF8,木_0_in + 子_12_in) ;
   if ( 子_13_do>0.0 )
   {
     子_10_do = 子_10_do + 子_13_do ;
     子_11_in ++;
   }
   if ( 子_12_in >= 总_85_in_AF8 )   break;
   
 }

 if ( 子_11_in >  0 )
 {
   子_10_do = 子_10_do / 子_11_in ;
 }
 if ( 子_9_do>子_10_do * 0.6 && 子_9_do<子_10_do * 1.5 )
 {
   子_2_in +=15;
 }
 return(MathMin(MathMax(子_2_in,0),100)); 
 }
//lizong_41 <<==--------   --------
 int lizong_42( int 木_0_in)
 {
 if ( 总_37_do_6F8_ko[木_0_in]!=INT_MAX )
 {
   return(3); 
 }
 if ( 总_36_do_6C4_ko[木_0_in]!=INT_MAX )
 {
   return(2); 
 }
 if ( 总_35_do_690_ko[木_0_in]!=INT_MAX )
 {
   return(1); 
 }
 if ( 总_40_do_794_ko[木_0_in]!=INT_MAX )
 {
   return(-3); 
 }
 if ( 总_39_do_760_ko[木_0_in]!=INT_MAX )
 {
   return(-2); 
 }
 if ( 总_38_do_72C_ko[木_0_in]!=INT_MAX )
 {
   return(-1); 
 }
 return(0); 
 }
//lizong_42 <<==--------   --------
 void lizong_43()
 {
  int       子_1_in;
  int       子_2_in;
  int       子_3_in;
//----- -----

 子_1_in=(int)ChartGetInteger(0,5,0);
 if ( 总_238_in_E20 == 子_1_in )   return;
 总_238_in_E20 = 子_1_in ;
 子_2_in = 1 ;
 子_3_in = 1 ;
 switch(子_1_in)
 {
   case 0 :
   子_2_in = 1 ;
   子_3_in = 1 ;
     break;
   case 1 :
   子_2_in = 1 ;
   子_3_in = 1 ;
     break;
   case 2 :
   子_2_in = 2 ;
   子_3_in = 1 ;
     break;
   case 3 :
   子_2_in = 3 ;
   子_3_in = 1 ;
     break;
   case 4 :
   子_2_in = 6 ;
   子_3_in = 1 ;
     break;
   case 5 :
   子_2_in = 14 ;
   子_3_in = 1 ;
     break;
   default :
   子_2_in = 2 ;
   子_3_in = 1 ;
 }
 SetIndexStyle(4,DRAW_HISTOGRAM,STYLE_SOLID,子_2_in,DeepPink); 
 SetIndexStyle(5,DRAW_HISTOGRAM,STYLE_SOLID,子_2_in,DeepPink); 
 SetIndexStyle(6,DRAW_HISTOGRAM,STYLE_SOLID,子_3_in,DeepPink); 
 SetIndexStyle(7,DRAW_HISTOGRAM,STYLE_SOLID,子_3_in,DeepPink); 
 SetIndexStyle(8,DRAW_HISTOGRAM,STYLE_SOLID,子_2_in,DodgerBlue); 
 SetIndexStyle(9,DRAW_HISTOGRAM,STYLE_SOLID,子_2_in,DodgerBlue); 
 SetIndexStyle(10,DRAW_HISTOGRAM,STYLE_SOLID,子_3_in,DodgerBlue); 
 SetIndexStyle(11,DRAW_HISTOGRAM,STYLE_SOLID,子_3_in,DodgerBlue); 
 SetIndexStyle(12,DRAW_HISTOGRAM,STYLE_SOLID,子_2_in,LimeGreen); 
 SetIndexStyle(13,DRAW_HISTOGRAM,STYLE_SOLID,子_2_in,LimeGreen); 
 SetIndexStyle(14,DRAW_HISTOGRAM,STYLE_SOLID,子_3_in,LimeGreen); 
 SetIndexStyle(15,DRAW_HISTOGRAM,STYLE_SOLID,子_3_in,LimeGreen); 
 SetIndexStyle(16,DRAW_HISTOGRAM,STYLE_SOLID,子_2_in,Orange); 
 SetIndexStyle(17,DRAW_HISTOGRAM,STYLE_SOLID,子_2_in,Orange); 
 SetIndexStyle(18,DRAW_HISTOGRAM,STYLE_SOLID,子_3_in,Orange); 
 SetIndexStyle(19,DRAW_HISTOGRAM,STYLE_SOLID,子_3_in,Orange); 
 ChartRedraw(0); 
 }
//lizong_43 <<==--------   --------
 void lizong_44()
 {
  string    子_1_st;
//----- -----
 string     临_st_1;
 uint       临_ui_2;
 double     临_do_3;
 int        临_in_4;
 int        临_in_5;
 int        临_in_6;
 string     临_st_7;
 double     临_do_8;
 double     临_do_9;
 string     临_st_10;
 uint       临_ui_11;
 double     临_do_12;
 int        临_in_13;
 int        临_in_14;
 int        临_in_15;
 string     临_st_16;
 double     临_do_17;
 double     临_do_18;

 临_st_1 = "Wingdings";
 临_ui_2 = 总_288_ui_161C;
 临_do_3 = 0.0;
 临_in_4 = 0;
 临_in_5 = 2;
 临_in_6 = 20;
 临_st_7 = CharToString(91);
 临_do_8 = 0.0;
 临_do_9 = 0.0;
 if ( ObjectFind(0,"B3LLogo") >= 0 )
 {
   ObjectDelete(0,"B3LLogo"); 
 }
 ObjectCreate(0,"B3LLogo",OBJ_LABEL,0,0,0.0); 
 ObjectSetText("B3LLogo",临_st_7,临_in_6,临_st_1,临_ui_2); 
 ObjectSet("B3LLogo",OBJPROP_CORNER,临_in_5); 
 ObjectSet("B3LLogo",OBJPROP_XDISTANCE,临_do_8 + 临_in_4); 
 ObjectSet("B3LLogo",OBJPROP_YDISTANCE,临_do_3 * 临_in_6 / 16.0 + 临_do_9); 
 ObjectSet("B3LLogo",1000,0.0); 
 ObjectSet("B3LLogo",OBJPROP_BACK,0.0); 
 子_1_st = 总_296_st_1678_si3[总_297_in_169C] ;
 临_st_10 = "Arial";
 临_ui_11 = 总_289_ui_1620;
 临_do_12 = 20.0;
 临_in_13 = 30;
 临_in_14 = 2;
 临_in_15 = 8;
 临_st_16 = 子_1_st;
 临_do_17 = 0.0;
 临_do_18 = 0.0;
 if ( ObjectFind(0,"B3LCopy") >= 0 )
 {
   ObjectDelete(0,"B3LCopy"); 
 }
 ObjectCreate(0,"B3LCopy",OBJ_LABEL,0,0,0.0); 
 ObjectSetText("B3LCopy",临_st_16,临_in_15,临_st_10,临_ui_11); 
 ObjectSet("B3LCopy",OBJPROP_CORNER,临_in_14); 
 ObjectSet("B3LCopy",OBJPROP_XDISTANCE,临_do_17 + 临_in_13); 
 ObjectSet("B3LCopy",OBJPROP_YDISTANCE,临_do_12 * 临_in_15 / 16.0 + 临_do_18); 
 ObjectSet("B3LCopy",1000,0.0); 
 ObjectSet("B3LCopy",OBJPROP_BACK,0.0); 
 }
//<<==lizong_44 <<==


 


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool UseCheck()
  {
   bool res = false;
   string promptMsg = "";
   string setAccount = Bind_Account;
   string setCompany = Company;
   datetime useExpiration = Use_Expiration_Time;
   if(Account_Control)
     {
      string useAccount[];
      int k = StringSplit(setAccount, useAccount, "+");
      for(int i = 0; i < k; i++)
        {
         if(AccountInfoInteger(ACCOUNT_LOGIN) == (int)useAccount[i])
           {
            res = true;
            break;
           }
        }
      if(!res)
         promptMsg = Account_Error_Reminder_Content;
     }
   else
     {
      res = true;
     }
   if(Time_Control && TimeCurrent() > useExpiration)
     {
      AddToPrompt(promptMsg, The_Deadline_Has_Reached_The_Reminder_Content);
      res = false;
     }
   if(Company_control && setCompany != "")
     {
      string company = AccountInfoString(ACCOUNT_COMPANY);
      if(StringFind(company, setCompany) < 0)
        {
         AddToPrompt(promptMsg, Company_Error_Reminder_Content);
         res = false;
        }
     }
   if(!res && promptMsg != "")
     {
      Alert(promptMsg);
     }
   return res;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void AddToPrompt(string &msg, string newMsg)
  {
   if(msg != "")
      msg += "\n" + newMsg;
   else
      msg = newMsg;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int StringSplit(string string_value, string &result[], string separator, string SEP = NULL)
  {
   StringTrimLeft(string_value);
   StringTrimRight(string_value);
   if(SEP != NULL)
      StringReplace(string_value, SEP, separator);
   ArrayFree(result);
   ushort u_sep = StringGetCharacter(separator, 0);
   return StringSplit(string_value, u_sep, result);
  }