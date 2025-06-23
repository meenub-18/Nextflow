params.ref="/home/ubuntu/ref/Agy99.fasta"
params.index_dir= "/home/ubuntu/ref/index_dir"

process index {

publishDir("${params.index_dir}", mode: 'copy')

input:
  path genome

output:
  path "${genome}.bwt", emit: ref_genome

script:
"""
bwa index $genome

"""
}

workflow {

ref_ch=channel.fromPath(params.ref)

index(ref_ch)
index.out.ref_genome.view()

}

