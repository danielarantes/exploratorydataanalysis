##################################
#!/bin/sh
echo "Running plot1.R..."
R CMD BATCH --no-save plot1.R
echo "Running plot2.R..."
R CMD BATCH --no-save plot2.R
echo "Running plot3.R..."
R CMD BATCH --no-save plot3.R
echo "Running plot4.R..."
R CMD BATCH --no-save plot4.R
##################################
