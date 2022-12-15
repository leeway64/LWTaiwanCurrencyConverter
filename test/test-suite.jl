using Test

include("../src/LWTaiwanCurrencyConverter.jl")


@testset "Exchange rates" begin
    @testset "USD to NTD conversion function" begin
        @testset "Zero" begin
            @test round(USDtoNTD(0, 1), digits = 2) == 0
        end

        @testset "Positive integers" begin
            @test round(USDtoNTD(1, 1), digits = 2) == 1
            @test round(USDtoNTD(2, 2), digits = 2) == 4
            @test round(USDtoNTD(100, 150), digits = 2) == 15000
            @test round(USDtoNTD(938, 175443), digits = 2) == 164565534
        end

        @testset "Positive doubles" begin
            @test round(USDtoNTD(1.0, 1.0), digits = 2) == 1.00
            @test round(USDtoNTD(3.83, 2.999), digits = 2) == 11.49
            @test round(USDtoNTD(4.56, 134.87), digits = 2) == 615.01
            @test round(USDtoNTD(838, 33.333), digits = 2) == 27933.05
        end
    end


    @testset "NTD to USD conversion function" begin
        @testset "Zero" begin
            @test round(NTDtoUSD(0, 1), digits = 2) == 0
        end

        @testset "Positive integers" begin
            @test round(NTDtoUSD(1, 1), digits = 2) == 1
            @test round(NTDtoUSD(1, 2), digits = 2) == 0.5
            @test round(NTDtoUSD(4, 2), digits = 2) == 2
            @test round(NTDtoUSD(33, 90), digits = 2) == 0.37
        end

        @testset "Positive doubles" begin
            @test round(NTDtoUSD(0.5, 0.75), digits = 2) == 0.67
            @test round(NTDtoUSD(300.25, 25.00), digits = 2) == 12.01
            @test round(NTDtoUSD(100023, 12.569), digits = 2) == 7957.91
            @test round(NTDtoUSD(800.87, 6.5897), digits = 2) == 121.53
        end
    end
end


@testset "Reading settings file" begin
    @testset "Empty file" begin
        settings1 = read_cfg_file("test/test-settings-files/empty.cfg")
        
        @test isempty(settings1)
    end

    @testset "File with comments but no settings" begin
        settings2 = read_cfg_file("test/test-settings-files/comments.cfg")
    end

    @testset "File with 1 setting" begin
        settings3 = read_cfg_file("test/test-settings-files/1-setting.cfg")
    end

    @testset "File with 3 settings" begin
        settings4 = read_cfg_file("test/test-settings-files/3-settings.cfg")
    end

    @testset "Edge case: File with 4 settings, comments, and whitespace" begin
        settings5 = read_cfg_file("test/test-settings-files/edge-case.cfg")
    end
end
