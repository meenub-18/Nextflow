params.ref="/home/ubuntu/ref/Agy99.fasta"

process index {

input:
  path genome

script:
"""
bwa index $genome

"""
}

workflow {

ref_ch=channel.fromPath(params.ref)

index(ref_ch)

}
 

