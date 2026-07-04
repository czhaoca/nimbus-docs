// @ts-check
import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';
import starlightOpenAPI, { openAPISidebarGroups } from 'starlight-openapi';

export default defineConfig({
	integrations: [
		starlight({
			title: 'Nimbus',
			social: [
				{ icon: 'github', label: 'GitHub', href: 'https://github.com/czhaoca/nimbus' },
			],
			sidebar: [
				{ label: 'Setup', autogenerate: { directory: 'setup' } },
				{ label: 'Providers', autogenerate: { directory: 'providers' } },
				{ label: 'Environments', autogenerate: { directory: 'environments' } },
				{ label: 'Operations', autogenerate: { directory: 'operations' } },
				{ label: 'Integrations', autogenerate: { directory: 'integrations' } },
				{ label: 'Networking', autogenerate: { directory: 'networking' } },
				{ label: 'CLI Reference', autogenerate: { directory: 'cli-reference' } },
				...openAPISidebarGroups,
				{ label: 'Reference', autogenerate: { directory: 'reference' } },
			],
		}),
		starlightOpenAPI([
			{
				base: 'api',
				label: 'API Reference',
				schema: './openapi.json',
			},
		]),
	],
});
