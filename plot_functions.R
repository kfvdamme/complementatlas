# boxplot

boxplot = function(dataset, variable, comparison, timepoint) {
  dataset_subset = dataset %>%
    filter(Day_chr == timepoint | Healthy == "yes") %>%
    select(Classifier = comparison, Test = variable) %>%
    filter(!Classifier == "")
  
  dataset_subset %>%
    ggplot(aes(x = Classifier, y = Test, fill = Classifier)) +
    scale_fill_manual(values = complement_atlas_colors) +
    geom_boxplot(alpha = 0.6, outlier.shape = NA, color = "grey40", size = 1) +
    geom_point(aes(color = Classifier), alpha = 0.3, position = position_jitterdodge(jitter.width = 0.8), size = 3) +
    scale_color_manual(values = complement_atlas_colors) +
    theme_hc() +
    ggtitle(paste(variable, "at", timepoint)) +
    theme(
      plot.title = element_text(size = 18, hjust = 0.5),
      axis.text = element_text(size = 16),
      legend.position = "null",
      axis.title.x = element_blank(),
      axis.title.y = element_blank(),
      axis.ticks.y = element_blank())
}

# evolutionplot

evolutionplot = function(dataset, variable, comparison, groups = 5) {
  dataset_summary = dataset %>%
    select(Classifier = comparison, variable, Timepoint) %>%
    filter(!Classifier == "") %>%
    filter(Timepoint == 1 | Timepoint == 2) %>%
    group_by(Classifier, Timepoint) %>%
    get_summary_stats(variable, type = "mean_ci")
  
  ggplot(dataset_summary[2:groups,], aes(x=Timepoint, y=mean, group=Classifier, color=Classifier)) +
    # grey area representing 95% CI of controls - requires factorization
    annotate("rect", xmin = 0.85, xmax = 2.15, 
             ymin = pull(dataset_summary[1,"mean"])+pull(dataset_summary[1,"ci"]), ymax = pull(dataset_summary[1,"mean"])-pull(dataset_summary[1,"ci"]), 
             alpha = .3,fill = "grey60") +
    geom_segment(aes(x = 0.85, y = pull(dataset_summary[1,"mean"])+pull(dataset_summary[1,"ci"]), 
                     xend = 2.15, yend = pull(dataset_summary[1,"mean"])+pull(dataset_summary[1,"ci"])), 
                 color = "grey56", linetype = "dotted", alpha = 0.7) +
    geom_segment(aes(x = 0.85, y = pull(dataset_summary[1,"mean"])-pull(dataset_summary[1,"ci"]), 
                     xend = 2.15, yend = pull(dataset_summary[1,"mean"])-pull(dataset_summary[1,"ci"])), 
                 color = "grey56", linetype = "dotted", alpha = 0.7) +
    geom_segment(aes(x = 0.85, y = pull(dataset_summary[1,"mean"]), 
                     xend = 2.15, yend = pull(dataset_summary[1,"mean"])), 
                 color = "grey56", linetype = "dashed", alpha = 0.7) +
    # evolution of COVID-19 subgroups
    geom_line(aes(group=Classifier, color=Classifier, linetype=Classifier), linewidth = 2, alpha=0.9) +
    scale_color_manual(values = complement_atlas_colors) +
    scale_linetype_manual(values=c("dashed", "solid")) +
    geom_errorbar(aes(x=Timepoint, y=ci, ymax=(mean+ci), ymin=(mean-ci)), alpha=0.6, width=0, size=5, linetype=1, show.legend = F) +
    geom_segment(aes(x=Timepoint-0.08,y=(mean+ci),xend=Timepoint+0.08,yend=(mean+ci), color=Classifier, alpha=0.4), size=2, show.legend = F) +
    geom_segment(aes(x=Timepoint-0.08,y=(mean-ci),xend=Timepoint+0.08,yend=(mean-ci), color=Classifier, alpha=0.4), size=2, show.legend = F) +
    geom_point(aes(color=Classifier, shape=Classifier), size=5, alpha=0.9) + 
    geom_point(aes(pch=Classifier),color="white", size=1.5, alpha=0.9) +
    scale_shape_manual(values=c(16, 18)) +
    # lay-out
    scale_x_continuous(breaks=c(0,1,2,3), labels=c("", "day 1","day 6", "")) +
    coord_cartesian(ylim = c((min(dataset_summary$mean)-max(dataset_summary$ci)) * 0.9,(max(dataset_summary$mean)+max(dataset_summary$ci)) * 1.1)) +
    ggtitle(paste(variable, "over time")) +
    labs(caption = "gray area represents 95% confidence interval of healthy controls") +
    theme_hc() +
    theme(legend.position="bottom",
          legend.key.width = unit(2.25, "cm"),
          plot.caption = element_text(size = 11, hjust = 0.5, face = "italic", color = "grey56"),
          plot.title = element_text(size=18, hjust=0.5),
          axis.text = element_text(size = 16),
          axis.title.x = element_blank(),
          axis.title.y = element_blank(),
          legend.text = element_text(size = 16),
          axis.ticks.y = element_blank(),
          legend.title = element_blank())
}


# violinplot

violinplot = function(dataset, variable, comparison, timepoint) {
  dataset_subset = dataset %>%
    filter(Exclude_aIL6_timepoint_2 == "no") %>% # day 6 samples of anti-IL-6 treated patients are excluded
    filter(Day_chr == timepoint | Healthy == "yes") %>%
    select(Classifier = comparison, Test = variable) %>%
    filter(!Classifier == "")
  
  dataset_subset %>%
    ggplot(aes(x = Classifier, y = Test, fill = Classifier)) +
    geom_violin(alpha = 0.6, draw_quantiles = 0.5, trim = T, colour = "grey40", size = 1) +
    geom_point(aes(color = Classifier), alpha = 0.6, position = position_jitterdodge(jitter.width = 0.8), size = 3) +
    scale_fill_manual(values = complement_atlas_colors) +
    scale_color_manual(values = complement_atlas_colors) +
    theme_hc() +
    ggtitle(paste(variable, "\nat", str_sub(timepoint, 1, -2))) +
    theme(
      plot.title = element_text(size = 18, hjust = 0.5),
      axis.text = element_text(size = 16),
      legend.position = "null",
      axis.title.x = element_blank(),
      axis.title.y = element_blank(),
      axis.ticks.y = element_blank())
}

# evolutionplot for effect of anti-IL drugs

evolutionplot_anti_IL = function(dataset, variable, comparison) {
  dataset_summary = dataset %>%
    filter(Exclude_anti_IL1_IL6_comparison != "yes") %>%
    select(Classifier = comparison, variable, Timepoint) %>%
    filter(!Classifier == "") %>%
    filter(Timepoint == 1 | Timepoint == 2) %>%
    group_by(Classifier, Timepoint) %>%
    get_summary_stats(variable, type = "mean_ci")
  
  ggplot(dataset_summary[2:5,], aes(x=Timepoint, y=mean, group=Classifier, color=Classifier)) +
    # grey area representing 95% CI of controls - requires factorization
    annotate("rect", xmin = 0.85, xmax = 2.15, 
             ymin = pull(dataset_summary[1,"mean"])+pull(dataset_summary[1,"ci"]), ymax = pull(dataset_summary[1,"mean"])-pull(dataset_summary[1,"ci"]), 
             alpha = .3,fill = "grey60") +
    geom_segment(aes(x = 0.85, y = pull(dataset_summary[1,"mean"])+pull(dataset_summary[1,"ci"]), 
                     xend = 2.15, yend = pull(dataset_summary[1,"mean"])+pull(dataset_summary[1,"ci"])), 
                 color = "grey56", linetype = "dotted", alpha = 0.7) +
    geom_segment(aes(x = 0.85, y = pull(dataset_summary[1,"mean"])-pull(dataset_summary[1,"ci"]), 
                     xend = 2.15, yend = pull(dataset_summary[1,"mean"])-pull(dataset_summary[1,"ci"])), 
                 color = "grey56", linetype = "dotted", alpha = 0.7) +
    geom_segment(aes(x = 0.85, y = pull(dataset_summary[1,"mean"]), 
                     xend = 2.15, yend = pull(dataset_summary[1,"mean"])), 
                 color = "grey56", linetype = "dashed", alpha = 0.7) +
    # evolution of COVID-19 subgroups
    geom_line(aes(group=Classifier, color=Classifier, linetype=Classifier), linewidth = 2, alpha=0.9) +
    scale_color_manual(values = complement_atlas_colors) +
    scale_linetype_manual(values=c("dashed", "solid")) +
    geom_errorbar(aes(x=Timepoint, y=ci, ymax=(mean+ci), ymin=(mean-ci)), alpha=0.6, width=0, size=5, linetype=1, show.legend = F) +
    geom_segment(aes(x=Timepoint-0.08,y=(mean+ci),xend=Timepoint+0.08,yend=(mean+ci), color=Classifier, alpha=0.4), size=2, show.legend = F) +
    geom_segment(aes(x=Timepoint-0.08,y=(mean-ci),xend=Timepoint+0.08,yend=(mean-ci), color=Classifier, alpha=0.4), size=2, show.legend = F) +
    geom_point(aes(color=Classifier, shape=Classifier), size=5, alpha=0.9) + 
    geom_point(aes(pch=Classifier),color="white", size=1.5, alpha=0.9) +
    scale_shape_manual(values=c(16, 18)) +
    # lay-out
    scale_x_continuous(breaks=c(0,1,2,3), labels=c("", "day 1","day 6", "")) +
    coord_cartesian(ylim = c((min(dataset_summary$mean)-max(dataset_summary$ci)) * 0.9,(max(dataset_summary$mean)+max(dataset_summary$ci)) * 1.1)) +
    ggtitle(paste(variable, "over time")) +
    labs(caption = "gray area represents 95% confidence interval of healthy controls") +
    theme_hc() +
    theme(legend.position="bottom",
          legend.key.width = unit(2.25, "cm"),
          plot.caption = element_text(size = 11, hjust = 0.5, face = "italic", color = "grey56"),
          plot.title = element_text(size=18, hjust=0.5),
          axis.text = element_text(size = 16),
          axis.title.x = element_blank(),
          axis.title.y = element_blank(),
          legend.text = element_text(size = 16),
          axis.ticks.y = element_blank(),
          legend.title = element_blank())
}
