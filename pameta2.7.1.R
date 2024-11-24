#' pameta
#'
#' This function allows you to load diseaseland excel into memory
#' @param inpt Filename exported from OmicSoft array studio
#' @param output prefix to the output output/csv file
#' @keywords expression-data.frame
#' @return return a file containing meta-analysis summary statistics
#' @import rvest
#' @import dplyr
#' @export
pameta<-function(inpt,output,type="norm"){
  options(warn = -1)
  matrix<-read_csv(inpt)
  matrix<-matrix %>% filter(Case.Treatment = "NA" | "none") # filter 'treatment samples
  matrix<-matrix %>% filter(PValue !=".")
  matrix<-matrix %>% filter(Log2FoldChange !="0")
  matrix$PValue[matrix$PValue<2.0*10^-16]<-2.0*10^-16
  #matrix$study<-paste(matrix$Case.DiseaseState,"-",matrix$Case.Tissue,sep="")
  matrix$study<-paste(matrix$Case.DiseaseState,"-",matrix$Case.SampleSource,sep="")
  matrix$PValue<-as.numeric(matrix$PValue)
  hk<-suppressWarnings(metaland(matrix,byvar=matrix$study,type))
  Study=gsub("byvar","",rownames(hk$b))
  K=as.numeric(table(matrix$study)[match(Study,names(table(matrix$study)))])
  out<-data.frame(Study,K=K,TE=hk$b,seTE=hk$se,zval=hk$zval,pval=hk$pval,ci.lb=hk$ci.lb,ci.ub=hk$ci.ub)
  otf<-paste(output,".disland.meta.csv",sep="")
  write.table(out,file=otf,row.names = F,col.names = T,quote=F,sep=",")
  print(paste(otf,"has been created and saved in", getwd(),"!",sep=" "))
}
