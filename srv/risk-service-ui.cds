using RiskService from './risk-service';

annotate RiskService.Risks with {
	title       @title: 'Title2';
	prio        @title: 'Priority';
	descr       @title: 'Description';
	miti        @title: 'Mitigation';
	impact      @title: 'Impact';
	supplier    @(
        title: 'Supplier',
        Common.Text: supplier.fullName,
        Common.TextArrangement: #TextOnly
    )
}

annotate RiskService.Mitigations with {
	ID @(
		UI.Hidden,
		Common: {
		Text: description
		}
	);
	description  @title: 'Description';
	owner        @title: 'Owner';
	timeline     @title: 'Timeline';
	risks        @title: 'Risks';
}

annotate RiskService.Risks with @(
	UI: {
		HeaderInfo: {
			TypeName: 'Risk',
			TypeNamePlural: 'Risks',
			Title          : {
                $Type : 'UI.DataField',
                Value : title
            },
			Description : {
				$Type: 'UI.DataField',
				Value: descr
			}
		},
		SelectionFields: [prio],
		LineItem: [
			{Value: title},
			
			{
				Value: prio,
				Criticality: criticality
			},
			{
				Value: impact,
				Criticality: criticality
			},
			
			{
				Value: descr
			},
			
			{
				Value: title
			}
		],
		Facets: [
			{$Type: 'UI.ReferenceFacet', Label: 'Main', Target: '@UI.FieldGroup#Main'}
		],
		FieldGroup#Main: {
			Data: [
				
				{
					Value: prio,
					Criticality: criticality
				},
				{
					Value: impact,
					Criticality: criticality
				},
				{
				Value: descr
			},
			
			{
				Value: title
			},
			{Value: supplier.ID},
            {Value: supplier.isBlocked},
			]
		}
	},
) {

};

annotate RiskService.Risks with {
	miti @(
		Common: {
			//show text, not id for mitigation in the context of risks
			Text: miti.description  , TextArrangement: #TextOnly,
			ValueList: {
				Label: 'Mitigations',
				CollectionPath: 'Mitigations',
				Parameters: [
					{ $Type: 'Common.ValueListParameterInOut',
						LocalDataProperty: miti.ID,
						ValueListProperty: 'ID'
					},
					{ $Type: 'Common.ValueListParameterDisplayOnly',
						ValueListProperty: 'description'
					}
				]
			}
		}
	);
}

annotate RiskService.Suppliers with {
    isBlocked   @title: 'Supplier Blocked';
}

// Annotations for value help

annotate RiskService.Risks with {
    supplier @(
        Common.ValueList: {
            Label: 'Suppliers',
            CollectionPath: 'Suppliers',
            Parameters: [
                { $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty: supplier.ID,
                    ValueListProperty: 'ID'
                },
                { $Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'fullName'
                }
            ]
        }
    );
}

annotate RiskService.Suppliers with {
    ID          @(
        title: 'ID',
        Common.Text: fullName
    );
    fullName    @title: 'Names';
}

annotate RiskService.Suppliers with @Capabilities.SearchRestrictions.Searchable : false;