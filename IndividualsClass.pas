unit IndividualsClass;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;
type
  TIndividual = class
  private
   geneLength : integer;
   fitness : integer;
  public
   genes : array of integer;
   constructor Create(length : integer);
   function getFitness(): integer;
   procedure calculateFitness(itemScore, itemWeight : array of integer; capacity : integer);
  end;

implementation
  constructor TIndividual.Create(length : integer);
   var
     index : integer;
   begin
     geneLength:= length;
     setLength(genes, length);
     Randomize;
     for index := 1 to length do
      begin
        genes[index] := Random(100) mod 2;
      end;
     fitness := 0;
   end;
  function TIndividual.getFitness(): integer;
  begin
    getFitness := fitness
  end;

  procedure TIndividual.calculateFitness(itemScore, itemWeight : array of integer; capacity : integer);
   var
     index : integer;
     totalWeight : integer;
   begin
     for index := 1 to genelength do
        totalWeight := totalWeight + (itemWeight[index] * genes[index]);
     if totalWeight > capacity then
      begin
        fitness:= 1;
      end
     else
      for index := 1 to geneLength do
         fitness := fitness + genes[index]*itemScore[index];
   end;
end.

