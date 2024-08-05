/// Create colored subtypes for sofas
#define COLORED_SOFA(path, color_name, sofa_color) \
path/middle/color_name {\
	color = sofa_color; \
} \
path/right/color_name {\
	color = sofa_color; \
} \
path/left/color_name {\
	color = sofa_color; \
} \
path/corner/color_name {\
	color = sofa_color; \
}

/obj/structure/chair/sofa/corp
	icon = 'modular_splurt/icons/obj/sofa.dmi'

COLORED_SOFA(/obj/structure/chair/sofa, brown, SOFA_BROWN)
COLORED_SOFA(/obj/structure/chair/sofa, maroon, SOFA_MAROON)
