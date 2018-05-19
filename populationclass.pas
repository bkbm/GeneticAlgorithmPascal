unit PopulationClass;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, IndividualsClass;
type
  TPopulation = class
   private
    populationSize : integer;
    fittest : integer;
    procedure initialisePopulation(geneLength : integer);
   public
    Individuals : array of TIndividual;
    constructor Create(geneLength, sizeOfPopulation : integer);
    function getPopulationSize(): integer;
    procedure CalculatePopulationFitness(itemScores, itemWeights : array of integer; capacity : integer);
  end;
implementation
constructor TPopulation.Create(geneLength, sizeOfPopulation : integer );
begin
  populationSize:= sizeOfPopulation;
  setLength(individuals,populationSize);
  initialisePopulation(geneLength);
  fittest := 1;
end;
function TPopulation.getPopulationSize(): integer;
begin
  getPopulationSize := populationSize;
end;

procedure TPopulation.initialisePopulation(geneLength : integer);
var
  index : integer;
begin
  for index := 1 to populationSize do
   begin
     individuals[index] := TIndividual.Create(geneLength);
   end;
end;
procedure TPopulation.CalculatePopulationFitness(itemScores, itemWeights : array of integer; capacity : integer);
var
  index : integer;
begin
  for index := 1 to populationSize do
   individuals[index].calculateFitness(itemScores, itemWeights,capacity);
  for index := 1 to populationSize do
   begin
     if individuals[index].getFitness() > individuals[fittest].getFitness() then
       fittest := index
   end;
end;
end.

