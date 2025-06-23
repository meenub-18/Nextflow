params.ref="/home/ubuntu/ref/Agy99.fasta"
params.index_dir= "/home/ubuntu/ref"

process index {

publishDir("${params.index_dir}", mode: 'copy')

input:
  path genome

output:
  path "*"

script:
"""
bwa index $genome

"""
}

workflow {

ref_ch=channel.fromPath(params.ref)

index(ref_ch)

}
 

