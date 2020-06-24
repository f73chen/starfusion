workflow test_location {
    call find_tools
}

task find_tools {
    command <<<
        ls -l /data/STAR_FUSION_GENOME_ROOT/test_star_fusion/reads_1.fq.gz
        ls -l /data/STAR_FUSION_GENOME_ROOT/test_star_fusion/reads_2.fq.gz
        ls -l /data/STAR_FUSION_GENOME_ROOT/test_star_fusion/test.Chimeric.out.junction
    >>>
    output{
        String message = read_string(stdout())
    }
    runtime {
        docker: "g3chen/starfusion:2.0"
    }
}
