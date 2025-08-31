params.index_dir="/home/ubuntu/nextfile/ref"
params.ref="Agy99.fasta"
params.fastq="/home/ubuntu/nextfile/fastq/*_{R1,R2}*"

params.bam_dir="/home/ubuntu/nextfile/BAM"

process mapping {

publishDir("${params.bam_dir}", mode: 'copy')

input:
 path index_dir
 val ref
 tuple val(sample_id), path(fastq)

output:
 path "*"

script:
"""
bwa mem ${index_dir}/${ref} ${fastq} | samtools view -h -b -o ${sample_id}.bam - 

"""
}

workflow {

index_ch=Channel.fromPath(params.index_dir)
ref_ch=Channel.of(params.ref)
fastq_ch=Channel.fromFilePairs(params.fastq)

mapping(index_ch,ref_ch,fastq_ch)
mapping.out.view()

}
