$SYMBOL_TAGS = {
	"CBH.TO" => {
		market: "CAD",
		type: "Bonds",
		sub_type: "Corporate (1-10)",
		distribution_frequency: :monthly
	},
	"CBO.TO" => {
		market: "CAD",
		type: "Bonds",
		sub_type: "Corporate (1-5)",
		distribution_frequency: :monthly
	},
	"CLF.TO" => {
		market: "CAD",
		type: "Bonds",
		sub_type: "Government (1-5)",
		distribution_frequency: :monthly
	},
	"CLG.TO" => {
		market: "CAD",
		type: "Bonds",
		sub_type: "Government (1-10)",
		distribution_frequency: :monthly
	},
	"HBB.TO" => {
		market: "CAD",
		type: "Bonds",
		sub_type: "Swap",
		distribution_frequency: :never
	},
	"VAB.TO" => {
		market: "CAD",
		type: "Bonds",
		sub_type: "Long term",
		distribution_frequency: :monthly
	},
	"VSB.TO" => {
		market: "CAD",
		type: "Bonds",
		sub_type: "Short term",
		distribution_frequency: :monthly
	},
	"XHB.TO" => {
		market: "CAD",
		type: "Bonds",
		sub_type: "Corporate",
		distribution_frequency: :monthly
	},
	"XQB.TO" => {
		market: "CAD",
		type: "Bonds",
		sub_type: "Long term",
		distribution_frequency: :monthly
	},
	"XSB.TO" => {
		market: "CAD",
		type: "Bonds",
		sub_type: "Short term",
		distribution_frequency: :monthly
	},


	"CPD.TO" => {
		market: "CAD",
		type: "Equity",
		sub_type: "Preferred stock",
		distribution_frequency: :monthly
	},
	"XIC.TO" => {
		market: "CAD",
		type: "Equity",
		sub_type: "All cap",
		distribution_frequency: :quarterly
	},
	"XRE.TO" => {
		market: "CAD",
		type: "Equity",
		sub_type: "REIT",
		distribution_frequency: :monthly
	},
	"VCE.TO" => {
		market: "CAD",
		type: "Equity",
		sub_type: "Med, large cap",
		distribution_frequency: :quarterly
	},
	"VCN.TO" => {
		market: "CAD",
		type: "Equity",
		sub_type: "All cap",
		distribution_frequency: :quarterly
	},

	"IYR" => {
		market: "US",
		type: "Equity",
		sub_type: "REIT",
		distribution_frequency: :quarterly
	},
	"REZ" => {
		market: "US",
		type: "Equity",
		sub_type: "REIT",
		distribution_frequency: :quarterly
	},
	"FILL" => {
		market: "Global",
		type: "Equity",
		sub_type: "Energy",
		distribution_frequency: :semi_annual,
		splits: {
			"US" => (51.84),
			"CAD" => (8.04),
			"Developed-Asia-Pacific" => (1.35 + 1.19 + (5.49 / 3)),
			"Developed-Europe"       => (8.73 + 8.6 + 5.56 + 2.39 + (5.49 / 3)),
			"Emerging"               => (2.59 + 2.54 + 1.21 + (5.49 / 3))
		}
	},
	"ICLN" => {
		market: "Global",
		type: "Equity",
		sub_type: "Clean energy",
		distribution_frequency: :semi_annual,
		splits: {
			"US" => (25.49),
			"Developed-Asia-Pacific" => (6.2 + 5.92 + (1.43 / 3)),
			"Developed-Europe"       => (7.57 + 6.98 + 6.32 + 4.34 + 3.37 + 2.17 + (1.43 / 3)),
			"Emerging"               => (25.17 + 5.02 + (1.43 / 3))
		}
	},
	"REM" => {
		market: "US",
		type: "Equity",
		sub_type: "Mortage REITs",
		distribution_frequency: :quarterly
	},
	"XT" => {
		market: "Global",
		type: "Equity",
		sub_type: "Exponential tech",
		distribution_frequency: :semi_annual,
		splits: {
			"US"  => (67.43),
			"CAD" => (1.92),
			"Developed-Asia-Pacific" => (1.72 + 1.71 + (7.11 / 3)),
			"Developed-Europe"       => (4.98 + 4.32 + 3.78 + 3.16 + 1.44 + 1.34 + (7.11 / 3)),
			"Emerging"               => (1.09 + (7.11 / 3))
		}
	},
	"PICK" => {
		market: "Global",
		type: "Equity",
		sub_type: "Mining",
		distribution_frequency: :semi_annual,
		splits: {
			"US"  => (13.61),
			"CAD" => (2.84),
			"Developed-Asia-Pacific" => (26.86 + 10.38 + (9.62 / 3)),
			"Developed-Europe"       => (10.21 + 4.55 + 2.15 + 1.38 + 1.21 + (9.62 / 3)),
			"Emerging"               => (3.51 + 2.72 + 2.2 + 2.14 + 1.29 + (9.62 / 3))
		}
	},
	"WPS" => {
		market: "Developed-Ex-US",
		type: "Equity",
		sub_type: "REIT",
		distribution_frequency: :quarterly,
		splits: {
			"Developed-Asia-Pacific" => (27.02 + 16.37 + 11.59 + 7.46 + (7.14 / 3)),
			"Developed-Europe"       => (12.32 + 6.95 + 4.35 + 2 + 1.72 + (7.14 / 3)),
			"CAD"             => (3.08),
			"Emerging"        => (7.14 / 3)
		}
	},
	"VGG.TO" => {
		market: "US",
		type: "Equity",
		sub_type: "Dividend",
		distribution_frequency: :quarterly
	},
	"VFV.TO" => {
		market: "US",
		type: "Equity",
		sub_type: "S&P 500",
		distribution_frequency: :quarterly
	},
	"VUN.TO" => {
		market: "US",
		type: "Equity",
		sub_type: "All cap",
		distribution_frequency: :quarterly
	},
	"VTI" => {
		market: "US",
		type: "Equity",
		sub_type: "All cap",
		distribution_frequency: :quarterly
	},
	"XHU.TO" => {
		market: "US",
		type: "Equity",
		sub_type: "Dividend",
		distribution_frequency: :monthly
	},
	"XUS.TO" => {
		market: "US",
		type: "Equity",
		sub_type: "Large cap",
		distribution_frequency: :semi_annual
	},
	"XUU.TO" => {
		market: "US",
		type: "Equity",
		sub_type: "All cap",
		distribution_frequency: :quarterly
	},


	"XEF.TO" => {
		market: "Developed-Ex-NA",
		type: "Equity",
		sub_type: "All cap",
		distribution_frequency: :semi_annual,
		splits: {
			"Developed-Asia-Pacific" => 33.334,
			"Developed-Europe"       => 66.666
		}
	},
	"VDU.TO" => {
		market: "Developed-Ex-NA",
		type: "Equity",
		distribution_frequency: :quarterly,
		splits: {
			"Developed-Asia-Pacific" => 33.334, # Best guesses based on XEF.TO (because Vanguard only lists ~80% of its holdings).
			"Developed-Europe"       => 66.666
		}
	},
	"VA.TO" => {
		market: "Developed-Asia-Pacific",
		type: "Equity",
		distribution_frequency: :quarterly
	},
	"XEU.TO" => {
		market: "Developed-Europe",
		type: "Equity",
		distribution_frequency: :semi_annual
	},
	"VE.TO" => {
		market: "Developed-Europe",
		type: "Equity",
		distribution_frequency: :quarterly
	},

	"VEE.TO" => {
		market: "Emerging",
		type: "Equity",
		distribution_frequency: :quarterly
	},
	"XEC.TO" => {
		market: "Emerging",
		type: "Equity",
		distribution_frequency: :semi_annual
	},

	"VXC.TO" => {
		market: "Ex-CAD",
		type: "Equity",
		splits: {
			"US"                     => 52.1,
			"Developed-Europe"       => 23.6,
			"Developed-Asia-Pacific" => 14.9,
			"Emerging"               => 9.4
		},
		distribution_frequency: :quarterly
	}
}