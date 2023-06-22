# colors
complement_atlas_colors = c(
  "healthy" = "#cccccc",
  "COVID-19" = "#b80219",
  "non-critical" = "#ffb703",
  "critical" = "#023047",
  "survivor" = "#f4c095", 
  "non-survivor" = "#cd7672",
  "control" = "#ee8000",
  "anti-C5" = "#2431b5",
  "no anti-IL-6(R)" = "#00798c",
  "anti-IL-6(R)" = "#d1495b",
  "no anti-IL-1" = "#2e4057",
  "anti-IL-1" = "#edae49"
)

# complement
complement = read.csv("./www/complement.csv", sep = ";", check.names=FALSE)
complement$Disease = factor(complement$Disease, levels = c("healthy", "COVID-19"))
complement$Critical = factor(complement$Critical, levels = c("healthy", "non-critical", "critical"))
complement$Survival = factor(complement$Survival, levels = c("healthy", "survivor", "non-survivor"))
complement$Anti_IL_6 = factor(complement$Anti_IL_6, levels = c("healthy", "no anti-IL-6(R)", "anti-IL-6(R)"))
complement$Anti_IL_1 = factor(complement$Anti_IL_1, levels = c("healthy", "no anti-IL-1", "anti-IL-1"))

# anti-C5
complement_anti_C5 = read.csv("./www/complement_anti_C5.csv", sep = ";", dec = ",", check.names = FALSE)
complement_anti_C5$Treatment = factor(complement_anti_C5$Treatment, levels = c("healthy", "control", "anti-C5"))

# complement function
complement_function = read.csv("./www/complement_function.csv", sep = ";", dec = ",", check.names = FALSE)
complement_function$Disease = factor(complement_function$Disease, levels = c("healthy", "COVID-19"))
complement_function$Critical = factor(complement_function$Critical, levels = c("healthy", "non-critical", "critical"))
complement_function$Survival = factor(complement_function$Survival, levels = c("healthy", "survivor", "non-survivor"))
complement_function$Anti_IL_6 = factor(complement_function$Anti_IL_6, levels = c("healthy", "no anti-IL-6(R)", "anti-IL-6(R)"))

# olink
olink = read.csv("./www/olink.csv", sep = ";", dec = ",", check.names = FALSE)
olink$Disease = factor(olink$Disease, levels = c("healthy", "COVID-19"))
olink$Critical = factor(olink$Critical, levels = c("healthy", "non-critical", "critical"))
olink$Survival = factor(olink$Survival, levels = c("healthy", "survivor", "non-survivor"))
olink$Treatment = factor(olink$Treatment, levels = c("healthy", "control", "anti-C5"))
proteins = colnames(olink)[83:3003]