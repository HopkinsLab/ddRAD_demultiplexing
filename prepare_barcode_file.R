###### This is an R script to prepare the barcode file for the demultiplexing step of the ddRAD sequence processing. #####
setwd("~/Documents/phlo_ddrad/")
#read in the barcode file
#library to read excel file
library("readxl")
datfile<-read_excel("sc_hybridzone_ddRAD_barcodes_2020.xlsx") #279 rows, 4 cols

#get rows for each illumina barcode
i1<-datfile[which(datfile$illumina_adapter == "i1"),]
i2<-datfile[which(datfile$illumina_adapter == "i2"),]
i3<-datfile[which(datfile$illumina_adapter == "i3"),]
i4<-datfile[which(datfile$illumina_adapter == "i4"),]

#check how many msp1 barcodes you have
unique(datfile$MspI_code) 
# 8 unique barcodes: [1] "MspI_3" "MspI_4" "MspI_5" "MspI_7" "MspI_6" "MspI_2" "MspI_8" "MspI_1"

#check how many pst1 barcodes you have
unique(datfile$PstI_code)
# 12 unique barcodes: [1] "PstI_2"  "PstI_5"  "PstI_3"  "PstI_8"  "PstI_6"  "PstI_7"  "PstI_9"  "PstI_11" "PstI_12" "PstI_10" "PstI_4"  "PstI_1" 

## msp barcodes
msp1<-"AACT"
msp2<-"CCAG"
msp3<-"TTGA"
msp4<-"GGTCA"
msp5<-"AACAT"
msp6<-"CCACG"
msp7<-"CTTGTA"
msp8<-"TCGTAT"

## pst barcodes
pst1<-"ACGG"
pst2<-"TGCT"
pst3<-"CATA"
pst4<-"CGAG"
pst5<-"GCTT"
pst6<-"ATCA"
pst7<-"GACG"
pst8<-"CTGT"
pst9<-"TCAA"
pst10<-"AGTCA"
pst11<-"CACG"
pst12<-"CTGCA"

######### i1 ######### 
#substitue Msp1 barcodes
i1[which(i1$MspI_code == "MspI_1"),][,2]<-msp1
i1[which(i1$MspI_code == "MspI_2"),][,2]<-msp2
i1[which(i1$MspI_code == "MspI_3"),][,2]<-msp3
i1[which(i1$MspI_code == "MspI_4"),][,2]<-msp4
i1[which(i1$MspI_code == "MspI_5"),][,2]<-msp5
i1[which(i1$MspI_code == "MspI_6"),][,2]<-msp6
i1[which(i1$MspI_code == "MspI_7"),][,2]<-msp7
i1[which(i1$MspI_code == "MspI_8"),][,2]<-msp8

#substitue Pst1 barcodes
i1[which(i1$PstI_code == "PstI_1"),][,3]<-pst1
i1[which(i1$PstI_code == "PstI_2"),][,3]<-pst2
i1[which(i1$PstI_code == "PstI_3"),][,3]<-pst3
i1[which(i1$PstI_code == "PstI_4"),][,3]<-pst4
i1[which(i1$PstI_code == "PstI_5"),][,3]<-pst5
i1[which(i1$PstI_code == "PstI_6"),][,3]<-pst6
i1[which(i1$PstI_code == "PstI_7"),][,3]<-pst7
i1[which(i1$PstI_code == "PstI_8"),][,3]<-pst8
i1[which(i1$PstI_code == "PstI_9"),][,3]<-pst9
i1[which(i1$PstI_code == "PstI_10"),][,3]<-pst10
i1[which(i1$PstI_code == "PstI_11"),][,3]<-pst11
i1[which(i1$PstI_code == "PstI_12"),][,3]<-pst12


######### i2 ######### 
#substitue Msp1 barcodes
i2[which(i2$MspI_code == "MspI_1"),][,2]<-msp1
i2[which(i2$MspI_code == "MspI_2"),][,2]<-msp2
i2[which(i2$MspI_code == "MspI_3"),][,2]<-msp3
i2[which(i2$MspI_code == "MspI_4"),][,2]<-msp4
i2[which(i2$MspI_code == "MspI_5"),][,2]<-msp5
i2[which(i2$MspI_code == "MspI_6"),][,2]<-msp6
i2[which(i2$MspI_code == "MspI_7"),][,2]<-msp7
i2[which(i2$MspI_code == "MspI_8"),][,2]<-msp8

#substitue Pst1 barcodes
i2[which(i2$PstI_code == "PstI_1"),][,3]<-pst1
i2[which(i2$PstI_code == "PstI_2"),][,3]<-pst2
i2[which(i2$PstI_code == "PstI_3"),][,3]<-pst3
i2[which(i2$PstI_code == "PstI_4"),][,3]<-pst4
i2[which(i2$PstI_code == "PstI_5"),][,3]<-pst5
i2[which(i2$PstI_code == "PstI_6"),][,3]<-pst6
i2[which(i2$PstI_code == "PstI_7"),][,3]<-pst7
i2[which(i2$PstI_code == "PstI_8"),][,3]<-pst8
i2[which(i2$PstI_code == "PstI_9"),][,3]<-pst9
i2[which(i2$PstI_code == "PstI_10"),][,3]<-pst10
i2[which(i2$PstI_code == "PstI_11"),][,3]<-pst11
i2[which(i2$PstI_code == "PstI_12"),][,3]<-pst12

######### i3 ######### 
#substitue Msp1 barcodes
i3[which(i3$MspI_code == "MspI_1"),][,2]<-msp1
i3[which(i3$MspI_code == "MspI_2"),][,2]<-msp2
i3[which(i3$MspI_code == "MspI_3"),][,2]<-msp3
i3[which(i3$MspI_code == "MspI_4"),][,2]<-msp4
i3[which(i3$MspI_code == "MspI_5"),][,2]<-msp5
i3[which(i3$MspI_code == "MspI_6"),][,2]<-msp6
i3[which(i3$MspI_code == "MspI_7"),][,2]<-msp7
i3[which(i3$MspI_code == "MspI_8"),][,2]<-msp8

#substitue Pst1 barcodes
i3[which(i3$PstI_code == "PstI_1"),][,3]<-pst1
i3[which(i3$PstI_code == "PstI_2"),][,3]<-pst2
i3[which(i3$PstI_code == "PstI_3"),][,3]<-pst3
i3[which(i3$PstI_code == "PstI_4"),][,3]<-pst4
i3[which(i3$PstI_code == "PstI_5"),][,3]<-pst5
i3[which(i3$PstI_code == "PstI_6"),][,3]<-pst6
i3[which(i3$PstI_code == "PstI_7"),][,3]<-pst7
i3[which(i3$PstI_code == "PstI_8"),][,3]<-pst8
i3[which(i3$PstI_code == "PstI_9"),][,3]<-pst9
i3[which(i3$PstI_code == "PstI_10"),][,3]<-pst10
i3[which(i3$PstI_code == "PstI_11"),][,3]<-pst11
i3[which(i3$PstI_code == "PstI_12"),][,3]<-pst12

######### i4 ######### 
#substitue Msp1 barcodes
i4[which(i4$MspI_code == "MspI_1"),][,2]<-msp1
i4[which(i4$MspI_code == "MspI_2"),][,2]<-msp2
i4[which(i4$MspI_code == "MspI_3"),][,2]<-msp3
i4[which(i4$MspI_code == "MspI_4"),][,2]<-msp4
i4[which(i4$MspI_code == "MspI_5"),][,2]<-msp5
i4[which(i4$MspI_code == "MspI_6"),][,2]<-msp6
i4[which(i4$MspI_code == "MspI_7"),][,2]<-msp7
i4[which(i4$MspI_code == "MspI_8"),][,2]<-msp8

#substitue Pst1 barcodes
i4[which(i4$PstI_code == "PstI_1"),][,3]<-pst1
i4[which(i4$PstI_code == "PstI_2"),][,3]<-pst2
i4[which(i4$PstI_code == "PstI_3"),][,3]<-pst3
i4[which(i4$PstI_code == "PstI_4"),][,3]<-pst4
i4[which(i4$PstI_code == "PstI_5"),][,3]<-pst5
i4[which(i4$PstI_code == "PstI_6"),][,3]<-pst6
i4[which(i4$PstI_code == "PstI_7"),][,3]<-pst7
i4[which(i4$PstI_code == "PstI_8"),][,3]<-pst8
i4[which(i4$PstI_code == "PstI_9"),][,3]<-pst9
i4[which(i4$PstI_code == "PstI_10"),][,3]<-pst10
i4[which(i4$PstI_code == "PstI_11"),][,3]<-pst11
i4[which(i4$PstI_code == "PstI_12"),][,3]<-pst12

#write out final file (make sure to check everything)
final_i1<-cbind(i1$PstI_code, i1$MspI_code, i1$Inidividual_ID)
final_i2<-cbind(i2$PstI_code, i2$MspI_code, i2$Inidividual_ID)
final_i3<-cbind(i3$PstI_code, i3$MspI_code, i3$Inidividual_ID)
final_i4<-cbind(i4$PstI_code, i4$MspI_code, i4$Inidividual_ID)

#write same file for two lanes just to ease demultiplexing
write.table(final_i1, "Hop_S_i1_S1_L001_barcodes.txt", sep="\t", quote=F, col.names = F, row.names = F)
write.table(final_i2, "Hop_S_i2_S2_L001_barcodes.txt", sep="\t", quote=F, col.names = F, row.names = F)
write.table(final_i3, "Hop_S_i3_S3_L001_barcodes.txt", sep="\t", quote=F, col.names = F, row.names = F)
write.table(final_i4, "Hop_S_i4_S4_L001_barcodes.txt", sep="\t", quote=F, col.names = F, row.names = F)

