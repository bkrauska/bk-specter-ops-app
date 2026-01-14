/** @type {import('tailwindcss').Config} */
export default {
	content: ['./src/**/*.{html,js,svelte,ts}'],
	theme: {
		extend: {
			colors: {
				agent: {
					primary: '#3b82f6',
					revealed: '#ef4444'
				},
				hunter: {
					1: '#10b981',
					2: '#f59e0b',
					3: '#8b5cf6',
					4: '#ec4899'
				},
				board: {
					floor: '#e5e7eb',
					wall: '#1f2937',
					objective: '#fbbf24'
				}
			}
		}
	},
	plugins: []
};
