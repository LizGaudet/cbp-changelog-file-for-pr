import "list"

// This section is only used by the templating system
#template: {
	schema:   string
	template: string
	data:     #data
	tmp?:     bool
}

#data: {
	title:       string
	description: string
	changelogs: list.MinItems(0) & [...#changelog]
}

#changelog: {
	title:    string
	anchor:   #anchor // This should be an iso-date so we can link to the specific item - 2020-01-01
	date:     string  // Dates are just English text shown in the headings
	icon?:    #icon
	content?: string
	entries: list.MinItems(0) & [...#entry]
}

#entry: {
	title:    string
	release:  #release // the release ID, e.g., "1.42".
	icon?:    #icon
	callout?: string
	content:  string
	references?: list.MinItems(0) & [...#reference]
	badges?: list.MinItems(0) & [...#badge]
}

// regex cue for anchor
#anchor: string
#anchor: =~"^\\d{4}-[0-9]{2}-[0-9]{2}$"

// We model this as a string because a float will truncate trailing zeros etc
#release: string
#release: =~"^([0-9]+\\.[0-9]+|[0-9]+\\.[0-9]+\\.[0-9]+)$"

#badge: {
	text: #badgeText
	type: #badgeType
}

#reference: #xref | #link

#xref: string
#xref: =~"^xref:.*$"

#link: string

#link: =~"^link:http.*]$"

// What’s new (New feature, New action: Green pill);
// Enhancements & performance (Feature enhancement, UI updates: Purple pill);
// Resolved issues (Bug fixes, Bug fixes, Security fixes, Yellow pill)
// Known issues and Upgrade notes not currently used

#badgeType: string
#badgeType: "warning" | "danger" | "success" | "info" | "primary" | "secondary" | "light" | "dark"

// Prevent blank dates
#dates: =~"^.{4,}$"

// Prevent blank badge text
#badgeText: =~"^.{2,}$"

#icon: "bug" | "chart-line" | "check" | "clipboard-check" | "exclamation-circle" | "plus-circle" | "puzzle-piece" | "toggle-on" | "tools" | "lock"
