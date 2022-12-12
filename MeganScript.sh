# Diamond and Megan
# Created by Lucas Vieira in 20/05/2022

pwd
# /media/lvieira/DiamondMegan
mkdir $(seq --format 'P0%.0f' 2 9)
mkdir $(seq --format 'P%.0f' 10 34)

# Initial meganization test
../Megan/tools/daa-meganizer -i Diamond_output_SP2.daa -mdb ../Megan/megan-map-Feb2022.db

# Data copied from HD4 to Rosane's external hard drive
for i in {12..34}
do
	cp /media/hd4/lucasvieira/Tese/SP"$i"-P"$i"/Diamond-Megan/Diamond_output_SP"$i".daa ./P"$i"/
done

cp /media/hd4/lucasvieira/Tese/SP10-P10/Diamond-Megan/Diamond_output_SP10.daa ./P10/

# Meganization
for i in {12..34}
do
	cd P"$i"
	../../Megan/tools/daa-meganizer -i Diamond_output_SP"$i".daa -mdb ../../Megan/megan-map-Feb2022.db -v true -tsm true -t 120
	cd ../
done

# It worked
../../Megan/tools/daa-meganizer -i Diamond_output_SP2.daa -mdb ../../Megan/megan-map-Feb2022.db -v true -tsm true -t 120

