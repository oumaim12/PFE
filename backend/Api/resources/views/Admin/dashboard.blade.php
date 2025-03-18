<x-app-layout>
    <x-slot name="header">
        <h2 class="header-title flex items-center">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z" />
            </svg>
            {{ __('Tableau de Bord') }}
        </h2>
    </x-slot>

    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        <!-- Ventes Totales -->
        <div class="content-panel relative overflow-hidden">
            <div class="panel-header bg-gradient-to-r from-engine-red to-engine-red/80">
                <div class="absolute top-0 right-0 mt-3 mr-3">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 text-white/30" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 7h6m0 10v-3m-3 3h.01M9 17h.01M9 14h.01M12 14h.01M15 11h.01M12 11h.01M9 11h.01M7 21h10a2 2 0 002-2V5a2 2 0 00-2-2H7a2 2 0 00-2 2v14a2 2 0 002 2z" />
                    </svg>
                </div>
                <h3 class="panel-title text-white">Ventes Totales</h3>
            </div>
            <div class="panel-body">
                <div class="flex flex-col">
                    <div class="text-3xl font-bold mb-1">{{ $totalSales }} commandes</div>
                    <div class="flex items-center text-sm">
                        @if($salesGrowth > 0)
                            <span class="text-green-500 flex items-center mr-1">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 mr-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7h8m0 0v8m0-8l-8 8-4-4-6 6" />
                                </svg>
                                {{ $salesGrowth }}%
                            </span>
                        @elseif($salesGrowth < 0)
                            <span class="text-red-500 flex items-center mr-1">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 mr-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 17h8m0 0v-8m0 8l-8-8-4 4-6-6" />
                                </svg>
                                {{ $salesGrowth }}%
                            </span>
                        @else
                            <span class="text-gray-400 flex items-center mr-1">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 mr-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 12h14" />
                                </svg>
                                0%
                            </span>
                        @endif
                        <span class="text-polished-chrome/70">depuis le mois dernier</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Clients -->
        <div class="content-panel relative overflow-hidden">
            <div class="panel-header bg-gradient-to-r from-exhaust-blue to-exhaust-blue/80">
                <div class="absolute top-0 right-0 mt-3 mr-3">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 text-white/30" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z" />
                    </svg>
                </div>
                <h3 class="panel-title text-white">Clients</h3>
            </div>
            <div class="panel-body">
                <div class="flex flex-col">
                    <div class="text-3xl font-bold mb-1">{{ $totalCustomers }}</div>
                    <div class="flex items-center text-sm">
                        @if($newCustomers > 0)
                            <span class="text-green-500 flex items-center mr-1">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 mr-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6" />
                                </svg>
                                {{ $newCustomers }}
                            </span>
                        @else
                            <span class="text-gray-400">0</span>
                        @endif
                        <span class="text-polished-chrome/70">nouveaux ce mois</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Commandes -->
        <div class="content-panel relative overflow-hidden">
            <div class="panel-header bg-gradient-to-r from-fuel-yellow to-fuel-yellow/80">
                <div class="absolute top-0 right-0 mt-3 mr-3">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 text-white/30" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z" />
                    </svg>
                </div>
                <h3 class="panel-title text-white">Commandes</h3>
            </div>
            <div class="panel-body">
                <div class="flex flex-col">
                    <div class="text-3xl font-bold mb-1">{{ $totalOrders }}</div>
                    <div class="flex items-center text-sm">
                        <span class="text-yellow-500 flex items-center mr-1">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 mr-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
                            </svg>
                            {{ $pendingOrders }}
                        </span>
                        <span class="text-polished-chrome/70">en attente</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Produits (Schémas) -->
        <div class="content-panel relative overflow-hidden">
            <div class="panel-header bg-gradient-to-r from-leather-brown to-leather-brown/80">
                <div class="absolute top-0 right-0 mt-3 mr-3">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 text-white/30" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 3v2m6-2v2M9 19v2m6-2v2M5 9H3m2 6H3m18-6h-2m2 6h-2M7 19h10a2 2 0 002-2V7a2 2 0 00-2-2H7a2 2 0 00-2 2v10a2 2 0 002 2zM9 9h6v6H9V9z" />
                    </svg>
                </div>
                <h3 class="panel-title text-white">Pièces</h3>
            </div>
            <div class="panel-body">
                <div class="flex flex-col">
                    <div class="text-3xl font-bold mb-1">{{ $totalProducts }}</div>
                    <div class="flex items-center text-sm">
                        <span class="text-polished-chrome/70">pièces disponibles</span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="grid grid-cols-1 lg:grid-cols-7 gap-6 mt-6">
        <!-- Graphique des commandes mensuelles -->
        <div class="content-panel lg:col-span-4">
            <div class="panel-header flex justify-between items-center">
                <h3 class="panel-title">Nombre de commandes mensuelles</h3>
            </div>
            <div class="panel-body">
                <div class="h-80">
                    <canvas id="sales-chart" class="chart-canvas"></canvas>
                </div>
            </div>
        </div>

        <!-- Top pièces demandées -->
        <div class="content-panel lg:col-span-3">
            <div class="panel-header flex justify-between items-center">
                <h3 class="panel-title">Top 5 des pièces les plus demandées</h3>
            </div>
            <div class="panel-body">
                <div class="h-80">
                    <canvas id="category-pie-chart" class="chart-canvas"></canvas>
                </div>
            </div>
        </div>
    </div>

    <!-- Commandes récentes -->
    <div class="content-panel mt-6">
        <div class="panel-header flex justify-between items-center">
            <h3 class="panel-title">Commandes récentes</h3>
            <a href="{{ route('commandes.index') }}" class="moto-button py-1 px-4 text-sm">VOIR TOUT</a>
        </div>
        <div class="panel-body p-0">
            <div class="overflow-x-auto">
                <table class="moto-table">
                    <thead>
                        <tr>
                            <th>COMMANDE</th>
                            <th>CLIENT</th>
                            <th>PIÈCE</th>
                            <th>DATE</th>
                            <th>STATUT</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse($recentOrders as $commande)
                            <tr>
                                <td class="font-semibold">#{{ $commande->id }}</td>
                                <td>
                                    <div class="flex items-center">
                                        <div class="w-8 h-8 rounded-full bg-carbon-fiber flex items-center justify-center mr-3">
                                            <span class="text-sm font-bold">{{ substr($commande->client->firstname, 0, 1) }}{{ substr($commande->client->lastname, 0, 1) }}</span>
                                        </div>
                                        <span>{{ $commande->client->firstname }} {{ $commande->client->lastname }}</span>
                                    </div>
                                </td>
                                <td>{{ $commande->schema->nom }}</td>
                                <td>{{ $commande->created_at->format('d/m/Y') }}</td>
                                <td>
                                    @if($commande->status == 'en_attente')
                                        <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-yellow-200 text-yellow-800">
                                            En attente
                                        </span>
                                    @elseif($commande->status == 'en_traitement')
                                        <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-blue-200 text-blue-800">
                                            En traitement
                                        </span>
                                    @elseif($commande->status == 'expediee')
                                        <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-indigo-200 text-indigo-800">
                                            Expédiée
                                        </span>
                                    @elseif($commande->status == 'livree')
                                        <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-200 text-green-800">
                                            Livrée
                                        </span>
                                    @elseif($commande->status == 'annulee')
                                        <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-red-200 text-red-800">
                                            Annulée
                                        </span>
                                    @endif
                                </td>
                                <td>
                                    <a href="{{ route('commandes.show', $commande->id) }}" class="text-engine-red hover:text-white transition-colors duration-200">
                                        Détails
                                    </a>
                                </td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="6" class="text-center py-8">
                                    <div class="flex flex-col items-center justify-center">
                                        <svg xmlns="http://www.w3.org/2000/svg" class="h-12 w-12 text-polished-chrome/30 mb-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1" d="M5 8h14M5 8a2 2 0 110-4h14a2 2 0 110 4M5 8v10a2 2 0 002 2h10a2 2 0 002-2V8m-9 4h4" />
                                        </svg>
                                        <span class="text-polished-chrome/70">Aucune commande récente</span>
                                    </div>
                                </td>
                            </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mt-6">
        <!-- Pièces les plus demandées -->
        <div class="content-panel">
            <div class="panel-header flex justify-between items-center">
                <h3 class="panel-title">Pièces les plus demandées</h3>
                <a href="{{ route('schemas.index') }}" class="moto-button py-1 px-4 text-sm">VOIR TOUT</a>
            </div>
            <div class="panel-body p-0">
                <table class="moto-table">
                    <thead>
                        <tr>
                            <th>PIÈCE</th>
                            <th>VERSION</th>
                            <th class="text-center">COMMANDES</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse($lowStockProductsList as $piece)
                            <tr>
                                <td class="font-semibold">{{ $piece->nom }}</td>
                                <td>{{ $piece->version }}</td>
                                <td class="text-center">
                                    <span class="inline-flex items-center justify-center px-2 py-1 text-xs font-bold leading-none rounded-full bg-exhaust-blue/20 text-exhaust-blue">
                                        {{ $piece->commandes->count() }}
                                    </span>
                                </td>
                                <td>
                                    <a href="{{ route('schemas.edit', $piece->id) }}" class="text-engine-red hover:text-white transition-colors duration-200">
                                        Modifier
                                    </a>
                                </td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="4" class="text-center py-8">
                                    <div class="flex flex-col items-center justify-center">
                                        <svg xmlns="http://www.w3.org/2000/svg" class="h-12 w-12 text-polished-chrome/30 mb-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1" d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14" />
                                        </svg>
                                        <span class="text-polished-chrome/70">Aucune pièce disponible</span>
                                    </div>
                                </td>
                            </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Derniers clients inscrits -->
        <div class="content-panel">
            <div class="panel-header flex justify-between items-center">
                <h3 class="panel-title">Derniers clients inscrits</h3>
                <a href="{{ route('clients.index') }}" class="moto-button py-1 px-4 text-sm">VOIR TOUT</a>
            </div>
            <div class="panel-body p-0">
                <table class="moto-table">
                    <thead>
                        <tr>
                            <th>CLIENT</th>
                            <th>EMAIL</th>
                            <th>DATE D'INSCRIPTION</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse($recentCustomers as $client)
                            <tr>
                                <td>
                                    <div class="flex items-center">
                                        <div class="w-8 h-8 rounded-full bg-carbon-fiber flex items-center justify-center mr-3">
                                            <span class="text-sm font-bold">{{ substr($client->firstname, 0, 1) }}{{ substr($client->lastname, 0, 1) }}</span>
                                        </div>
                                        <div>
                                            <div class="font-semibold">{{ $client->firstname }} {{ $client->lastname }}</div>
                                            <div class="text-xs text-polished-chrome/70">{{ $client->phone }}</div>
                                        </div>
                                    </div>
                                </td>
                                <td>{{ $client->email }}</td>
                                <td>{{ $client->created_at->format('d/m/Y') }}</td>
                                <td>
                                    <a href="{{ route('clients.show', $client->id) }}" class="text-engine-red hover:text-white transition-colors duration-200">
                                        Détails
                                    </a>
                                </td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="4" class="text-center py-8">
                                    <div class="flex flex-col items-center justify-center">
                                        <svg xmlns="http://www.w3.org/2000/svg" class="h-12 w-12 text-polished-chrome/30 mb-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                                        </svg>
                                        <span class="text-polished-chrome/70">Aucun client récent</span>
                                    </div>
                                </td>
                            </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    @push('scripts')
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Configuration des couleurs
            const colors = {
                red: '#D12026', 
                blue: '#2B6CC4',
                yellow: '#F9A602',
                gray: '#2F2F2F',
                chrome: '#E8E8E8'
            };

            // Fonction pour créer un dégradé
            function createGradient(ctx, startColor, endColor) {
                const gradient = ctx.createLinearGradient(0, 0, 0, 400);
                gradient.addColorStop(0, startColor);
                gradient.addColorStop(1, endColor);
                return gradient;
            }

            // Graphique des commandes mensuelles
            const salesCtx = document.getElementById('sales-chart').getContext('2d');
            const salesGradient = createGradient(salesCtx, 'rgba(209, 32, 38, 0.8)', 'rgba(209, 32, 38, 0.1)');
            
            new Chart(salesCtx, {
                type: 'line',
                data: {
                    labels: {!! json_encode($monthlySalesLabels) !!},
                    datasets: [{
                        label: 'Commandes',
                        data: {!! json_encode($monthlySalesData) !!},
                        fill: true,
                        backgroundColor: salesGradient,
                        borderColor: colors.red,
                        borderWidth: 2,
                        tension: 0.4,
                        pointBackgroundColor: colors.red,
                        pointBorderColor: '#fff',
                        pointBorderWidth: 2,
                        pointRadius: 4,
                        pointHoverRadius: 6
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: false
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            grid: {
                                color: 'rgba(255, 255, 255, 0.05)'
                            },
                            ticks: {
                                color: 'rgba(232, 232, 232, 0.7)'
                            }
                        },
                        x: {
                            grid: {
                                color: 'rgba(255, 255, 255, 0.05)'
                            },
                            ticks: {
                                color: 'rgba(232, 232, 232, 0.7)'
                            }
                        }
                    }
                }
            });
            
            // Graphique des pièces les plus demandées
            const categoryCtx = document.getElementById('category-pie-chart').getContext('2d');
            new Chart(categoryCtx, {
                type: 'doughnut',
                data: {
                    labels: {!! json_encode($topCategoriesLabels) !!},
                    datasets: [{
                        data: {!! json_encode($topCategoriesData) !!},
                        backgroundColor: [
                            colors.red,
                            colors.blue,
                            colors.yellow,
                            '#844C2C',
                            '#5E35B1'
                        ],
                        borderWidth: 2,
                        borderColor: '#1E1E1E'
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'right',
                            labels: {
                                color: 'rgba(232, 232, 232, 0.7)',
                                padding: 20,
                                font: {
                                    size: 12
                                }
                            }
                        }
                    },
                    cutout: '70%'
                }
            });
        });
    </script>
    @endpush
</x-app-layout>