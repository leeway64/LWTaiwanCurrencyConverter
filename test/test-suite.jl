using Test

include("../src/LWTaiwanCurrencyConverter.jl")


@testset "Exchange rates" begin
    @testset "USD to NTD conversion function" begin
        @testset "Zero" begin

        end

        @testset "Positive integers" begin
        end

        @testset "Positive doubles" begin
        end
    end


    @testset "NTD to USD conversion function" begin
        @testset "Zero" begin

        end

        @testset "Positive integers" begin
        end

        @testset "Positive doubles" begin
        end
    end
end


@testset "Reading settings file" begin
    @testset "Empty file" begin
    end

    @testset "File with comments but no settings" begin
    end

    @testset "File with 1 setting" begin
    end

    @testset "File with 3 settings" begin
    end

    @testset "Edge case: File with 4 settings, comments, and whitespace" begin
    end
end
