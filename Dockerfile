FROM rocker/tidyverse:4.1.0

ENV SYNAPSE_AUTH_TOKEN=""

# hadolint ignore=DL3008
RUN apt-get update -qq -y \
    && apt-get install --no-install-recommends -qq -y \
        libxt6 \
    && apt-get -y autoclean \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/*

# hadolint ignore=DL3059
RUN Rscript -e "install.packages('argparse')" \
    && Rscript -e "install.packages('flexdashboard')" \
    && Rscript -e "install.packages('rjson')" \
    && Rscript -e "install.packages('plotly')" \
    && Rscript -e "install.packages('ggplot2')" \
    && Rscript -e "install.packages('synapser', repos=c('http://ran.synapse.org', 'http://cran.fhcrc.org'))"

WORKDIR /
COPY participation-dashboard.Rmd performance-dashboard.Rmd task-dashboard.Rmd task-dashboard.css render_markdown.R config.json ./
RUN chmod a+x render_markdown.R
