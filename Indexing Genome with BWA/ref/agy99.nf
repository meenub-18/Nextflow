params.ref="/home/ubuntu/genome/myagy99.fasta"

process index {

input:
  path seq

script:
"""
bwa index $seq

"""
}

workflow {

genome_ch=channel.fromPath(params.ref)

index(genome_ch)

}
 

