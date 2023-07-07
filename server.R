server <- function(input, output) {
  
  output$plot_complement <- renderPlot(
    {
      if (input$select1 == "control vs anti-C5*" & input$select2 == "evolution") {
        
        dataset_summary = complement_anti_C5 %>%
          select(Timepoint, Classifier = Treatment, 'sC5b-9 (MAC)') %>%
          group_by(Classifier, Timepoint) %>%
          get_summary_stats('sC5b-9 (MAC)', type = "mean_ci")
        
        ggplot(dataset_summary[2:9,], aes(x=Timepoint, y=mean, group=Classifier, color=Classifier)) +
          # grey area representing 95% CI of controls - requires factorization
          annotate("rect", xmin = 0.85, xmax = 3.15, 
                   ymin = pull(dataset_summary[1,"mean"])+pull(dataset_summary[1,"ci"]), ymax = pull(dataset_summary[1,"mean"])-pull(dataset_summary[1,"ci"]), 
                   alpha = .3,fill = "grey60") +
          geom_segment(aes(x = 0.85, y = pull(dataset_summary[1,"mean"])+pull(dataset_summary[1,"ci"]), 
                           xend = 3.15, yend = pull(dataset_summary[1,"mean"])+pull(dataset_summary[1,"ci"])), 
                       color = "grey56", linetype = "dotted", alpha = 0.7) +
          geom_segment(aes(x = 0.85, y = pull(dataset_summary[1,"mean"])-pull(dataset_summary[1,"ci"]), 
                           xend = 3.15, yend = pull(dataset_summary[1,"mean"])-pull(dataset_summary[1,"ci"])), 
                       color = "grey56", linetype = "dotted", alpha = 0.7) +
          geom_segment(aes(x = 0.85, y = pull(dataset_summary[1,"mean"]), 
                           xend = 3.15, yend = pull(dataset_summary[1,"mean"])), 
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
          scale_x_continuous(breaks=c(0,1,1.35,2,3,4), labels=c("", "day 1", "day 2", "day 6", "day 15**", "")) +
          coord_cartesian(ylim = c((min(dataset_summary$mean)-max(dataset_summary$ci)) * 0.9,(max(dataset_summary$mean)+max(dataset_summary$ci)) * 1.1)) +
          ggtitle("sC5b-9 (MAC) over time") +
          labs(caption = "gray area represents 95% CI of healthy controls\n** :day 15 or hospital discharge, whichever came first") +
          theme_hc() +
          theme(legend.position="bottom",
                plot.caption = element_text(size = 11, hjust = 0.5, face = "italic", color = "grey56"),
                legend.key.width = unit(2.25, "cm"),
                plot.title = element_text(size=18, hjust=0.5),
                axis.text = element_text(size = 16),
                axis.title.x = element_blank(),
                axis.title.y = element_blank(),
                legend.text = element_text(size = 14),
                axis.ticks.y = element_blank(),
                legend.title = element_blank())
        
      } else if (input$select1 == "control vs anti-C5*") {
        
        boxplot(dataset = complement_anti_C5, variable = "sC5b-9 (MAC)", comparison = "Treatment", timepoint = input$select2)
        
      } else if (input$select1 == "non-critical vs critical" & input$select2 == "evolution") {
        
        evolutionplot(dataset = complement, variable = input$select_complement, comparison = "Critical")
        
      } else if (input$select1 == "survivor vs non-survivor" & input$select2 == "evolution") {
        
        evolutionplot(dataset = complement, variable = input$select_complement, comparison = "Survival")
        
      } else if (input$select1 == "healthy vs COVID-19" & input$select2 == "evolution") {
        
        evolutionplot(dataset = complement, variable = input$select_complement, comparison = "Disease", groups = 3)
      
      } else if (input$select1 == "non-critical vs critical") {
        
        boxplot(dataset = complement, variable = input$select_complement, comparison = "Critical", timepoint = input$select2)
        
      } else if (input$select1 == "survivor vs non-survivor") {
        
        boxplot(dataset = complement, variable = input$select_complement, comparison = "Survival", timepoint = input$select2)
      
      } else if (input$select1 == "healthy vs COVID-19") {
        
        boxplot(dataset = complement, variable = input$select_complement, comparison = "Disease", timepoint = input$select2)
        
      } 
    }
  )
  
  output$plot_pathway <- renderPlot(
    {
      if (input$select3 == "non-critical vs critical") {
        
        violinplot(dataset = complement_function, variable = paste("functional", input$select_pathway, "pathway"), comparison = "Critical", timepoint = input$select4)

      } else if (input$select3 == "survivor vs non-survivor") {
        
        violinplot(dataset = complement_function, variable = paste("functional", input$select_pathway, "pathway"), comparison = "Survival", timepoint = input$select4)
      
        } else if (input$select3 == "healthy vs COVID-19") {
        
        violinplot(dataset = complement_function, variable = paste("functional", input$select_pathway, "pathway"), comparison = "Disease", timepoint = input$select4)
        
      }
    }
  )
  
  output$plot_proteomics <- renderPlot(
    {
      if (input$select5 == "non-critical vs critical" & input$select6 == "evolution") {

        evolutionplot(dataset = olink, variable = input$text, comparison = "Critical")
                
      } else if (input$select5 == "survivor vs non-survivor" & input$select6 == "evolution") {
        
        evolutionplot(dataset = olink, variable = input$text, comparison = "Survival")
      
      } else if (input$select5 == "healthy vs COVID-19" & input$select6 == "evolution") {
        
        evolutionplot(dataset = olink, variable = input$text, comparison = "Disease", groups = 3)
        
      } else if (input$select5 == "control vs anti-C5") {
        
        evolutionplot(dataset = olink, variable = input$text, comparison = "Treatment")
        
      } else if (input$select5 == "non-critical vs critical") {
        
        boxplot(dataset = olink, variable = input$text, comparison = "Critical", timepoint = input$select6)
        
      } else if (input$select5 == "survivor vs non-survivor") {
        
        boxplot(dataset = olink, variable = input$text, comparison = "Survival", timepoint = input$select6)
      
      } else if (input$select5 == "healthy vs COVID-19") {
        
        boxplot(dataset = olink, variable = input$text, comparison = "Disease", timepoint = input$select6)
        
      }
    }
  )
  
  output$plot_IL_blockade <- renderPlot(
    {
      if (input$select_complement2 == "functional classical pathway*" | input$select_complement2 == "functional lectin pathway*" | input$select_complement2 == "functional alternative pathway*") {
        
        evolutionplot_anti_IL(dataset = complement_function, variable = str_sub(input$select_complement2, 1, -2), comparison = "Anti_IL_6")
        
      } else if (input$select_intervention == "anti-IL-6(R) with tocilizumab or siltuximab") {
        
        evolutionplot_anti_IL(dataset = complement, variable = input$select_complement2, comparison = "Anti_IL_6")
        
      } else if (input$select_intervention == "anti-IL-1 with anakinra") {
        
        evolutionplot_anti_IL(dataset = complement, variable = input$select_complement2, comparison = "Anti_IL_1")
        
      }
    }
  )
} 