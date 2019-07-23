library(DiagrammeR)

 grViz("
 digraph boxes_and_circles {

   # a 'graph' statement
   graph [overlap = true, fontsize = 10]

   # several 'node' statements
   node [shape = folder,
         fontname = Helvetica,
         style = filled,
         fillcolor = YellowGreen]
   'raw seq'; 'reference genome'

   node [shape = oval,
         fontname = Helvetica,
         style = filled,
         fillcolor = Gold2]
   'filenames.csv'; 'split_filenames.txt'

   node [shape = folder,
         fillcolor = red,
         fontname = Helvetica]
   'quality scores'; 'Denovo reads'; 'Denovo results'; 'SNP assembly'

   node [shape = circle,
         fillcolor = LightSteelBlue2]
   trimmomatic; fastqc; trinity; bowtie1; bowtie2; star; GATK
   
   node [shape = box,
        fillcolor = DarkOrange2,
        fontname = Helvetica]
   'Denovo Assembly'; SNP

   # 'edge' statements
  'raw seq' -> {fastqc 'filenames.csv' 'split_filenames.txt'}
  fastqc -> {trimmomatic 'quality scores' 'Denovo Assembly'}
  trimmomatic -> fastqc
'Denovo Assembly' -> trinity
trinity -> 'Denovo reads'
trinity -> bowtie1
'reference genome' -> bowtie1
bowtie1 -> 'Denovo results'
trimmomatic -> SNP
SNP -> bowtie2
SNP -> star
bowtie2 -> GATK
GATK -> 'SNP assembly'
star -> GATK
'filenames.csv' -> fastqc
'split_filenames.txt' -> trinity

 }
 ")
