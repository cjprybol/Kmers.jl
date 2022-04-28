@testset "EveryKmer" begin
    @testset "EveryKmer DNA" begin
        s = randdnaseq(500)
        s2 = LongDNA{2}(s)
        @test collect(EveryKmer(s, Val{31}())) == collect(EveryKmer(s2, Val{31}()))
        @test length(EveryKmer(s, Val{31}())) == length(EveryKmer(s2, Val{31}())) == 470
        
        @test collect(EveryKmer(s, Val{201}())) == collect(EveryKmer(s2, Val{201}()))
        @test length(EveryKmer(s, Val{201}())) == length(EveryKmer(s2, Val{201}())) == 300
    end
    
    @testset "EveryKmer RNA" begin
        s = randrnaseq(500)
        s2 = LongRNA{2}(s)
        @test collect(EveryKmer(s, Val{31}())) == collect(EveryKmer(s2, Val{31}()))
        @test length(EveryKmer(s, Val{31}())) == length(EveryKmer(s2, Val{31}())) == 470
        
        @test collect(EveryKmer(s, Val{201}())) == collect(EveryKmer(s2, Val{201}()))
        @test length(EveryKmer(s, Val{201}())) == length(EveryKmer(s2, Val{201}())) == 300
    end
    
    @testset "EveryKmer AA" begin
        s = randaaseq(500)
        s2 = LongAA(s)
        @test collect(EveryKmer(s, Val{31}())) == collect(EveryKmer(s2, Val{31}()))
        @test length(EveryKmer(s, Val{31}())) == length(EveryKmer(s2, Val{31}())) == 470
    
        @test collect(EveryKmer(s, Val{201}())) == collect(EveryKmer(s2, Val{201}()))
        @test length(EveryKmer(s, Val{201}())) == length(EveryKmer(s2, Val{201}())) == 300
    end
end

@testset "SpacedKmers" begin
    @testset "SpacedKmers DNA" begin
        s = randdnaseq(500)
        s2 = LongDNA{2}(s)
        @test collect(SpacedKmers(s, Val{31}(), 50)) == collect(SpacedKmers(s2, Val{31}(), 50))
        @test length(SpacedKmers(s, Val{31}(), 50)) == length(SpacedKmers(s2, Val{31}(), 50)) == 10
        
        @test collect(SpacedKmers(s, Val{201}(), 50)) == collect(SpacedKmers(s2, Val{201}(), 50))
        @test length(SpacedKmers(s, Val{201}(), 50)) == length(SpacedKmers(s2, Val{201}(), 50)) == 6
    end
    
    @testset "SpacedKmers RNA" begin
        s = randrnaseq(500)
        s2 = LongRNA{2}(s)
        @test collect(SpacedKmers(s, Val{31}(), 50)) == collect(SpacedKmers(s2, Val{31}(), 50))
        @test length(SpacedKmers(s, Val{31}(), 50)) == length(SpacedKmers(s2, Val{31}(), 50)) == 10
        
        @test collect(SpacedKmers(s, Val{201}(), 50)) == collect(SpacedKmers(s2, Val{201}(), 50))
        @test length(SpacedKmers(s, Val{201}(), 50)) == length(SpacedKmers(s2, Val{201}(), 50)) == 6
    end
    
    @testset "SpacedKmers AA" begin
        s = randaaseq(500)
        s2 = LongAA(s)
        @test collect(SpacedKmers(s, Val{31}(), 50)) == collect(SpacedKmers(s2, Val{31}(), 50))
        @test length(SpacedKmers(s, Val{31}(), 50)) == length(SpacedKmers(s2, Val{31}(), 50)) == 10
    
        @test collect(SpacedKmers(s, Val{201}(), 50)) == collect(SpacedKmers(s2, Val{201}(), 50))
        @test length(SpacedKmers(s, Val{201}(), 50)) == length(SpacedKmers(s2, Val{201}(), 50)) == 6
    end
end

@testset "EveryCanonicalKmer" begin
    @testset "EveryCanonicalKmer DNA" begin
        s = randdnaseq(500)
        s2 = LongDNA{2}(s)
        
        # Iterator generates expected results...
        ## 2-Bit DNA
        @test [(x[1], canonical(x[2])) for x in EveryKmer(s2, Val{31}())] ==
            collect(EveryCanonicalKmer(s2, Val{31}()))
        
        @test [(x[1], canonical(x[2])) for x in EveryKmer(s2, Val{201}())] ==
            collect(EveryCanonicalKmer(s2, Val{201}()))
        
        ## 4-Bit DNA
        @test [(x[1], canonical(x[2])) for x in EveryKmer(s, Val{31}())] ==
            collect(EveryCanonicalKmer(s, Val{31}()))
            
        @test [(x[1], canonical(x[2])) for x in EveryKmer(s, Val{201}())] ==
            collect(EveryCanonicalKmer(s, Val{201}()))
        
        # Test equivalency between different levels of bit compression...
        @test [x[2] for x in EveryCanonicalKmer(s, Val{31}())] ==
            [x[2] for x in EveryCanonicalKmer(s2, Val{31}())]
        @test all(iscanonical.([x[2] for x in EveryCanonicalKmer(s, Val{31}())])) &&
            all(iscanonical.([x[2] for x in EveryCanonicalKmer(s2, Val{31}())]))
        
        @test [x[2] for x in EveryCanonicalKmer(s, Val{201}())] ==
            [x[2] for x in EveryCanonicalKmer(s2, Val{201}())]
        @test all(iscanonical.([x[2] for x in EveryCanonicalKmer(s, Val{201}())])) &&
            all(iscanonical.([x[2] for x in EveryCanonicalKmer(s2, Val{201}())]))
    end
    
    @testset "EveryCanonicalKmer RNA" begin
        s = randrnaseq(500)
        s2 = LongRNA{2}(s)
        
        # Iterator generates expected results...
        ## 2-Bit DNA
        @test [(x[1], canonical(x[2])) for x in EveryKmer(s2, Val{31}())] ==
            collect(EveryCanonicalKmer(s2, Val{31}()))
        
        @test [(x[1], canonical(x[2])) for x in EveryKmer(s2, Val{201}())] ==
            collect(EveryCanonicalKmer(s2, Val{201}()))
        
        ## 4-Bit DNA
        @test [(x[1], canonical(x[2])) for x in EveryKmer(s, Val{31}())] ==
            collect(EveryCanonicalKmer(s, Val{31}()))
            
        @test [(x[1], canonical(x[2])) for x in EveryKmer(s, Val{201}())] ==
            collect(EveryCanonicalKmer(s, Val{201}()))
        
        # Test equivalency between different levels of bit compression...
        @test [x[2] for x in EveryCanonicalKmer(s, Val{31}())] ==
            [x[2] for x in EveryCanonicalKmer(s2, Val{31}())]
        @test all(iscanonical.([x[2] for x in EveryCanonicalKmer(s, Val{31}())])) &&
            all(iscanonical.([x[2] for x in EveryCanonicalKmer(s2, Val{31}())]))
        
        @test [x[2] for x in EveryCanonicalKmer(s, Val{201}())] ==
            [x[2] for x in EveryCanonicalKmer(s2, Val{201}())]
        @test all(iscanonical.([x[2] for x in EveryCanonicalKmer(s, Val{201}())])) &&
            all(iscanonical.([x[2] for x in EveryCanonicalKmer(s2, Val{201}())]))
    end
end