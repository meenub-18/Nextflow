
process TRIM {

publishDir "TRIMMED",pattern:'*trimmed*.fastq.gz',mode:'copy'
publishDir "FASTP_REPORT", pattern:'*fastp.html', mode:'copy'
publishDir "FASTP_REPORT", pattern:'*fastp.json', mode:'copy'


input:
   tuple val(sampleid), path(reads)

output:
   path "*"
   path "*trimmed*", emit: trimmed_reads

script:
"""
fastp -i ${reads[0]} -I ${reads[1]} -o ${sampleid}.trimmed.R1.fastq.gz -O ${sampleid}.trimmed.R2.fastq.gz \\ 
--json ${sampleid}.fastp.json --html ${sampleid}.fastq.html --thread 5 --detect_adapter_for_pe

"""
}


process QC {

piblishDir "FASTQC_REPORT/${description}", pattern: '*fastqc*', mode:'copy'
publishDir "MultiQC_REPORT/${description}", pattern:'multiqc*',mode:'copy'

input:
  tuple val(description), path(read1), path(read2)

output:
  path '*'

script:

"""
fastqc ${read1} ${read2}
multiqc --fullnames *fastqc*
"""

}

workflow {

Channel.fromFilePairs(params.reads) | TRIM \
| set{trimmed}

trimmed.trimmed_reads | map {reads -> tuple('trimmed_reads',"$reads[0]}","${reads[1]}")} \
|set{final_trim}

Channel.fromFilePairs(params.reads) \
[map{reads -> tuple ("raw_reads","${reads[1][0]}","${reads[1][1]}")} \
[set{raw}

final_trim.mix(raw).groupTuple() | QC 

}
