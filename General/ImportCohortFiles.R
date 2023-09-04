# import a file for each sample
## import CNV -----
importCNVkit <- function(pathCNV) {
  
  checkmate::assertAccess(pathCNV, access = "r")
  sprintf("Importing CNV: %s", pathCNV) %>% ParallelLogger::logInfo()
  
  sample.CNV <- readr::read_tsv(pathCNV, col_types = "cddcdddddddd") %>% 
    GenomicRanges::makeGRangesFromDataFrame(keep.extra.columns = TRUE) %>% cleanSeqLevel()
  sample.CNV$sample <- base::factor(base::gsub("_vcf\\.cns", 
                                               "", base::basename(pathCNV)))
  sprintf("\tReturning GRanges") %>% ParallelLogger::logTrace()
  return(sample.CNV)
}



# import Per Sample -----

importDNAofSample <- function (sampleId, inputFolder) 
{
  checkmate::assertCharacter(sampleId)
  checkmate::assertAccess(inputFolder, access = "r")
  sprintf("Importing DNA data of: %s", sampleId) %>% ParallelLogger::logInfo()
  library(GenomicRanges)
  dataSample <- list()

  ####### import CNV ####
  #sampleId <- gsub('_vs.*', '', sampleId)
  cnvFiles <- base::list.files(inputFolder, full.names = TRUE, pattern = paste0(sampleId, '\\.call\\.cns$'))
  dataSample$copyNumbers <- importCNVkit(pathCNV = cnvFiles
                                         
  return(dataSample)
}

                                         
# import Whole cohort -----
importDNAofCohort <- function (sampleIds, inputFolder, nThreads = 1, performAggregation = TRUE) 
{
  checkmate::assertCharacter(sampleIds)
  checkmate::assertAccess(inputFolder, access = "r")
  checkmate::assertNumber(nThreads)
  checkmate::assertLogical(performAggregation)
  
  sprintf("Importing DNA-seq data of %s samples.", dplyr::n_distinct(sampleIds)) %>% 
    ParallelLogger::logInfo()
  
  sampleIds <- unique(sampleIds)
  
  data.PerSample <- pbapply::pblapply(sampleIds, function(x) {
    importDNAofSample(x, inputFolder)
  }, cl = nThreads)
  
  base::names(data.PerSample) <- sampleIds
  if (performAggregation) {
    sprintf("Aggregating DNA-seq data of %s samples.", dplyr::n_distinct(sampleIds)) %>% ParallelLogger::logInfo()
    data.AllSamples <- list()
    data.AllSamples$copyNumbers <- base::unlist(GenomicRanges::GRangesList(base::lapply(data.PerSample, function(x) x$copyNumbers)))
  }
  else {
    return(data.PerSample)
  }
  return(data.AllSamples)
}


                                         
