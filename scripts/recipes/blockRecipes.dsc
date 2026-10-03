# Heavily requested recipe for crafting gilded blackstone
# Custom recipes for vanilla blocks will be denoted with "dBlock_"
dBlock_Gilded_Blackstone:
    type: item
    debug: false
    material: gilded_blackstone
    # Being that the block crafted is a vanilla block, this key should be true
    allow in material recipes: true
    recipes:
        1:
            type: shaped
            # A custom recipe_id and a group will be used to merge custom recipes for vanilla items in the recipe book
            recipe_id: crafted_gilded_blackstone
            group: building
            output_quantity: 4
            # The recipe requires 5 gold nuggets and 4 blackstone. The crafting result is 4 gilded blackstone
            input:
            - gold_nugget|blackstone|gold_nugget
            - blackstone|gold_nugget|blackstone
            - gold_nugget|blackstone|gold_nugget
    # The crafted gilded blackstone should be treated as a vanila block, not as a unique item
    no_id: true