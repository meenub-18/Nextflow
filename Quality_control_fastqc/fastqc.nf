params.fastq="/home/ubuntu/nextflow/fastq/*.fastq.gz"

process QC {

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
