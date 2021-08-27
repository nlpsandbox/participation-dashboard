FROM rocker/tidyverse:4.1.0

ENV SYNAPSE_AUTH_TOKEN=""

# hadolint ignore=DL3008
RUN apt-get update -qq -y \
    && apt-get install --no-install-recommends -qq -y \
        libxt6 \
    && apt-get -y autoclean \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/*

RUN Rscript -e "install.packages('argparse')" \
    && Rscript -e "install.packages('flexdashboard')" \
    && Rscript -e "install.packages('synapser', repos=c('http://ran.synapse.org', 'http://cran.fhcrc.org'))"

WORKDIR /
COPY participation-dashboard.Rmd render_markdown.R ./
RUN chmod a+x render_markdown.R
