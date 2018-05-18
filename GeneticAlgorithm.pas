program GeneticAlgorithm;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, sysutils, IndividualsClass, PopulationClass;
type
  indexArray =  array of integer;
  individualArray = array of TIndividual;
var
  Population : TPopulation;

function rouletteSelection(population : TPopulation; parentNumber: integer): indexArray;
 var
   index, count, sum : integer;
   probability : array of double;
   sumOfProbabilities, randomNumber : double;
   parentSelected : boolean;
 begin
   setLength(rouletteSelection, parentNumber);
   setLength(probability, population.getPopulationSize());
   sum := 0;
   sumOfProbabilities := 0;
   for index := 1 to population.getPopulationSize() do
    sum := sum + population.Individuals[index].getFitness();
   for index := 1 to population.getPopulationSize() do
    begin
      probability[index] :=  sumOfProbabilities + (population.Individuals[index].getFitness()/sum);
      sumOfProbabilities := sumOfProbabilities + probability[index];
    end;
   for index := 1 to parentNumber do
    begin
      Randomize();
      randomNumber:=random;
      parentSelected:= false;
      count := 1;
      repeat
        if randomNumber < probability[count] then
         begin
           rouletteSelection[index] := count;
           parentSelected:= True;
         end
        else
         count := count + 1;
      until parentSelected;
    end;
 end;
function selectParent(population : TPopulation; selectedIndex: indexArray; parentNumber : integer) : individualArray;
 var
   index : integer;
 begin
   setLength(selectParent, parentNumber);
   for index := 1 to length(selectedIndex) do
    begin
      selectParent[index] :=population.Individuals[selectedIndex[index]] ;
    end;
 end;
function crossover(parent : individualArray): integer;
 var
   crossoverIndex, index: integer;
 begin
   Randomize();
   crossoverIndex := random(length(parent));

 end;

begin
end.

