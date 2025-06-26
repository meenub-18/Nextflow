params.fastq="/home/ubuntu/nextflow/fastq/*.fastq.gz"

params.qc_report="/home/ubuntu/nextflow/fastqc_report"

process QC {

publishDir("${params.qc_report}", mode: 'copy')

input:
  path fastq

output:
  path "*"

script:
"""
fastqc $fastq

"""
}

workflow {
fastq_ch=Channel.fromPath(params.fastq)
QC(fastq_ch)
QC.out.view()
}
