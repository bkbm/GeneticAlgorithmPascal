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
  SelectedNumber : indexArray;
  Parents, subset1, subset2 : individualArray;
  ItemScore, ItemWeight : array[1..6] of integer;
  capacity, index : integer;
procedure splitArray(completeArray: individualArray; out Subset1; out Subset2);
var
  firstArray, secondArray : individualArray;
  index, midpoint : integer;
begin
  SetLength(firstArray, length(completeArray) div 2);
  SetLength(secondArray, length(completeArray) div 2);
  midpoint := Length(completeArray) div 2;
  for index := 1 to midpoint do
   begin
     firstArray[index] := completeArray[index];
     secondArray[index] := completeArray[index + midpoint];
   end;
end;
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
   crossover := 1;
 end;

begin
  capacity := 40;
  for index := 1 to 6 do
   ItemScore[index] := index;
  ItemWeight[1] := 10;
  ItemWeight[2] := 5;
  ItemWeight[3] := 15;
  ItemWeight[4] := 12;
  ItemWeight[5] := 20;
  ItemWeight[6] := 16;
  Population := TPopulation.Create(6,10);
  Population.CalculatePopulationFitness(ItemScore,ItemWeight,capacity);
  SelectedNumber:= rouletteSelection(Population,4);
  Parents := selectParent(Population,SelectedNumber, 4);
  splitArray(Parents,subset1,subset2);
  ReadLn;
end.

