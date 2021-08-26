FROM rocker/tidyverse:4.1.0

RUN apt-get update -y
RUN apt-get install -y --no-install-recommends libxt6

RUN Rscript -e "install.packages('argparse')"
RUN Rscript -e "install.packages('flexdashboard')"
RUN Rscript -e "install.packages('synapser', repos=c('http://ran.synapse.org', 'http://cran.fhcrc.org'))"

COPY participation-dashboard.Rmd ./
COPY render_markdown.R ./
RUN chmod a+x render_markdown.R
